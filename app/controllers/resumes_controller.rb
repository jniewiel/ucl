# <!-- app/controllers/resumes_controller.rb -->

class ResumesController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user! # Ensure the user is logged in before any action
  before_action :set_resume, only: %i[show edit update destroy] # Find the resume for actions that require it
  after_action :verify_authorized, except: :index # Verify authorization was done after actions except index
  after_action :verify_policy_scoped, only: :index # Verify that policy scope was applied for the index action

  def index
    # Fetch resumes based on the policy scope
    @resumes = policy_scope(Resume)
  end

  def select
    # Fetch resumes based on the policy scope and render as JSON
    @resumes = policy_scope(Resume)
    render json: { resumes: @resumes }
  end

  def show
    # Authorize access to the resume
    authorize @resume
  end

  def new
    # Initialize a new resume and authorize it
    @resume = Resume.new
    authorize @resume
  end

  def create
    # Build a new resume associated with the current user and authorize it
    @resume = current_user.resumes.build(resume_params)
    authorize @resume

    if @resume.save
      # Redirect to the resume's show page with a success notice
      redirect_to @resume, notice: 'Resume was successfully created.'
    else
      # Log and render the new template if validation errors occur
      Rails.logger.debug "Rendering new template due to validation errors"
      render :new
    end
  end

  def edit
    # Authorize access to edit the resume
    authorize @resume
  end

  def update
    # Authorize access to update the resume
    authorize @resume

    if @resume.update(resume_params)
      # Redirect to the resume's show page with a success notice
      redirect_to @resume, notice: 'Resume was successfully updated.'
    else
      # Log and render the edit template if validation errors occur
      Rails.logger.debug "Rendering edit template due to validation errors"
      render :edit
    end
  end

  def destroy
    # Authorize access to destroy the resume
    authorize @resume
    @resume.destroy
    # Redirect to the resumes index page with a success notice
    redirect_to resumes_url, notice: 'Resume was successfully destroyed.'
  end

  private

  # Find the resume based on the ID parameter
  def set_resume
    @resume = Resume.find(params[:id])
  end

  # Permit only the trusted parameters for resumes
  def resume_params
    params.require(:resume).permit(:resume, :extracted_text)
  end
end
