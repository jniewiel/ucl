# <!-- app/controllers/cover_letters_controller.rb -->

class CoverLettersController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user! # Ensure the user is logged in before any action
  before_action :set_cover_letter, only: %i[show edit update destroy] # Find the resume for actions that require it

  def index
    # Retrieve cover letters based on the policy scope
    @cover_letters = policy_scope(CoverLetter)
  end

  def show
    # Authorize access to the cover letter
    authorize(@cover_letter)
  end

  def new
    # Initialize a new cover letter and authorize it
    @cover_letter = CoverLetter.new
    authorize(@cover_letter)
  end

  def edit
    # Authorize access to edit the cover letter
    authorize(@cover_letter)
  end

  def generate
    resume = params[:resume]
    job_description = params[:job_description]

    Rails.logger.debug "Parameters received: resume=#{resume}, job_description=#{job_description}"

    openai_service = OpenaiService.new
    generated_cover_letter = openai_service.generate_highlighted_cover_letter(resume, job_description)

    respond_to do |format|
      format.html { render :new }
      format.json { render json: { cover_letter: generated_cover_letter.gsub("\n", "<br>") } }
    end
  end

  def save
    cover_letter_text = params[:cover_letter]
    job_posting_id = params[:job_posting_id]

    Rails.logger.debug "Parameters received: cover_letter=#{cover_letter_text}, job_posting_id=#{job_posting_id}"

    if job_posting_id.nil?
      render({ :json => { :error => "Job posting ID is required" }, :status => :bad_request })
      return
    end

    job_posting = JobPosting.find_by({ :id => job_posting_id })

    unless job_posting
      render({ :json => { :error => "Job posting does not exist" }, :status => :unprocessable_entity })
      return
    end

    @cover_letter = CoverLetter.new({
      :cover_letter_text => cover_letter_text,
      :user_id => current_user.id,
      :job_posting_id => job_posting.id,
    })

    if @cover_letter.save
      render json: { success: "Cover letter saved successfully" }
    else
      Rails.logger.debug "Cover Letter Save Errors: #{@cover_letter.errors.full_messages.join(", ")}"
      render json: { error: "Failed to save cover letter" }, status: :unprocessable_entity
    end
  end

  def create
    # Initialize a new cover letter with permitted parameters
    @cover_letter = CoverLetter.new(cover_letter_params)
    @cover_letter.user = current_user
    authorize(@cover_letter)

    if @cover_letter.save
      # Redirect to the cover letter's show page with a success notice
      redirect_to @cover_letter, notice: "Cover letter was successfully created."
    else
      # Render the new template if saving fails
      render :new
    end
  end

  def update
    # Authorize the cover letter before updating
    authorize @cover_letter

    if @cover_letter.update(cover_letter_params)
      # Redirect to the cover letter's show page with a success notice
      redirect_to @cover_letter, notice: "Cover letter was successfully updated."
    else
      # Render the edit template if updating fails
      render :edit
    end
  end

  def destroy
    # Authorize the cover letter before destroying it
    authorize(@cover_letter)
    @cover_letter.destroy
    
    # Redirect to the index page with a success notice
    redirect_to cover_letters_url, notice: "Cover letter was successfully destroyed."
  end

  private

  # Finds the cover letter based on the ID parameter
  def set_cover_letter
    @cover_letter = CoverLetter.find(params[:id])
  end

  # Permits only the allowed parameters for cover letters
  def cover_letter_params
    params.require(:cover_letter).permit(:cover_letter_text, :job_posting_id)
  end
end
