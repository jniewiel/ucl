# <!-- app/controllers/job_postings_controller.rb -->

class JobPostingsController < ApplicationController
  before_action :set_job_posting, only: %i[ show edit update destroy ]

  # GET /job_postings or /job_postings.json
  def index
    @job_postings = JobPosting.all
  end

  def select
    job_postings = JobPosting.all
    render({ :json => { :job_postings => job_postings } })
  end

  def fetch_job_posting_id
    job_description = params[:job_description]
    job_posting = JobPosting.find_by({ :job_description => job_description })

    if job_posting
      render({ :json => { :job_posting_id => job_posting.id } })
    else
      render({ :json => { :error => "Job posting not found" }, :status => :not_found })
    end
  end

  # GET /job_postings/1 or /job_postings/1.json
  def show
    render :show
  end

  # GET /job_postings/new
  def new
    @job_posting = JobPosting.new
  end

  # GET /job_postings/1/edit
  def edit
  end

  # POST /job_postings or /job_postings.json
  def create
    @job_posting = JobPosting.new(job_posting_params)

    respond_to do |format|
      if @job_posting.save
        format.html { redirect_to job_posting_url(@job_posting), notice: "Job posting was successfully created." }
        format.json { render :show, status: :created, location: @job_posting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_postings/1 or /job_postings/1.json
  def update
    respond_to do |format|
      if @job_posting.update(job_posting_params)
        format.html { redirect_to job_posting_url(@job_posting), notice: "Job posting was successfully updated." }
        format.json { render :show, status: :ok, location: @job_posting }
      else
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

  # Use callbacks to share common setup or constraints between actions.
  def set_job_posting
    @job_posting = JobPosting.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_posting_params
    params.require(:job_posting).permit(:created_at, :updated_at, :job_posting, :job_description)
  end
end
