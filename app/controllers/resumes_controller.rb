# <!-- app/controllers/resumes_controller.rb -->

class ResumesController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :set_resume, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @resumes = policy_scope(Resume)
  end

  def select
    @resumes = policy_scope(Resume)
    render json: { resumes: @resumes }
  end

  def show
    authorize @resume
  end

  def new
    @resume = Resume.new
    authorize @resume
  end

  def create
    @resume = current_user.resumes.build(resume_params)
    authorize @resume
    if @resume.save
      redirect_to @resume, notice: 'Resume was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @resume
  end

  def update
    authorize @resume
    if @resume.update(resume_params)
      redirect_to @resume, notice: 'Resume was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @resume
    @resume.destroy
    redirect_to resumes_url, notice: 'Resume was successfully destroyed.'
  end

  private

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def resume_params
    params.require(:resume).permit(:resume, :extracted_text)
  end
end
