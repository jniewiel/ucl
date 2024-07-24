# app/controllers/cover_letters_controller.rb

class CoverLettersController < ApplicationController
  def new
  end

  def generate
    resume = params[:resume]
    job_description = params[:job_description]

    # @cover_letter = AiService.generate_cover_letter(resume, job_description)
    
    # Testing placeholder:
    @cover_letter = "This is a generated cover letter based on the provided resume and job description."
    
    render :new
  end
end
