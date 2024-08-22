# <!-- app/controllers/job_postings_controller.rb -->

class JobPostingsController < ApplicationController
  before_action :set_job_posting, only: %i[show edit update destroy]

  # GET /job_postings or /job_postings.json
  def index
    # Fetch all job postings for listing
    @job_postings = JobPosting.all
  end

  def select
    # Fetch all job postings and render them as JSON
    job_postings = JobPosting.all
    render json: { job_postings: job_postings }
  end

  def fetch_job_posting_id
    # Retrieve job posting based on job description
    job_description = params[:job_description]
    job_posting = JobPosting.find_by(job_description: job_description)

    if job_posting
      # Return job posting ID if found
      render json: { job_posting_id: job_posting.id }
    else
      # Return error if job posting not found
      render json: { error: "Job posting not found" }, status: :not_found
    end
  end

  # GET /job_postings/1 or /job_postings/1.json
  def show
    # Render the show view for a specific job posting
    render :show
  end

  # GET /job_postings/new
  def new
    # Initialize a new job posting object
    @job_posting = JobPosting.new
  end

  # GET /job_postings/1/edit
  def edit
  end

  # POST /job_postings or /job_postings.json
  def create
    # Initialize a new job posting with permitted parameters
    @job_posting = JobPosting.new(job_posting_params)

    respond_to do |format|
      if @job_posting.save
        # Redirect to the job posting's show page on success
        format.html { redirect_to job_posting_url(@job_posting), notice: "Job posting was successfully created." }
        format.json { render :show, status: :created, location: @job_posting }
      else
        # Render the new template with errors if save fails
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_postings/1 or /job_postings/1.json
  def update
    respond_to do |format|
      if @job_posting.update(job_posting_params)
        # Redirect to the job posting's show page on successful update
        format.html { redirect_to job_posting_url(@job_posting), notice: "Job posting was successfully updated." }
        format.json { render :show, status: :ok, location: @job_posting }
      else
        # Render the edit template with errors if update fails
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_postings/1 or /job_postings/1.json
  def destroy
    @job_posting.destroy!

    respond_to do |format|
      format.html { redirect_to job_postings_url, notice: "Job posting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Set the job posting for actions that require it
  def set_job_posting
    @job_posting = JobPosting.find(params[:id])
  end

  # Permit only the trusted parameters for job postings
  def job_posting_params
    params.require(:job_posting).permit(:created_at, :updated_at, :job_posting, :job_description)
  end
end
