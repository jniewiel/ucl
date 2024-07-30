# <!-- app/controllers/resumes_controller.rb -->

class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume, only: [:show, :edit, :update, :destroy]

  def index
    @resumes = current_user.resumes
  end

  def show
  end

  def new
    @resume = Resume.new
  end

  def create
    @resume = current_user.resumes.build(resume_params)
    if @resume.save
      redirect_to @resume, notice: 'Resume was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @resume.update(resume_params)
      redirect_to @resume, notice: 'Resume was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
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
