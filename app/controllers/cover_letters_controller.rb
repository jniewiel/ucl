# app/controllers/cover_letters_controller.rb

class CoverLettersController < ApplicationController
  require_relative '../services/openai_service'

  def generate
    resume = params[:resume]
    job_description = params[:job_description]

    openai_service = OpenaiService.new
    @cover_letter = openai_service.generate_cover_letter(resume, job_description)

    respond_to do |format|
      format.html { render :new }
      format.json { render json: { cover_letter: @cover_letter.gsub("\n", "<br>") } }
    end
  end
end
