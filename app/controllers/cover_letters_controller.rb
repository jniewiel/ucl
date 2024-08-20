# <!-- app/controllers/cover_letters_controller.rb -->

class CoverLettersController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user! # Ensure the user is logged in before any action
  before_action :set_cover_letter, only: %i[show edit update destroy] # Find the resume for actions that require it
  after_action :verify_authorized, except: :index # Verify authorization was done after actions except index
  after_action :verify_policy_scoped, only: :index # Verify that policy scope was applied for the index action

  def index
    # Retrieve cover letters based on the policy scope
    @cover_letters = policy_scope(CoverLetter)
  end

  def show
    # Authorize access to the cover letter
    authorize @cover_letter
  end

  def new
    # Initialize a new cover letter and authorize it
    @cover_letter = CoverLetter.new
    authorize @cover_letter
  end

  def edit
    # Authorize access to edit the cover letter
    authorize @cover_letter
  end

  def create
    # Initialize a new cover letter with permitted parameters
    @cover_letter = CoverLetter.new(cover_letter_params)
    @cover_letter.user = current_user
    authorize @cover_letter

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
    authorize @cover_letter
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
