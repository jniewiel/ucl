# <!-- app/controllers/cover_letters_controller.rb -->

class CoverLettersController < ApplicationController
  require_relative '../services/openai_service'
  
  before_action :set_cover_letter, only: %i[ show edit update destroy ]

  # GET /cover_letters or /cover_letters.json
  def index
    @cover_letters = CoverLetter.all
  end

  # GET /cover_letters/1 or /cover_letters/1.json
  def show
  end

  # GET /cover_letters/new
  def new
    @cover_letter = CoverLetter.new
  end

  # GET /cover_letters/1/edit
  def edit
  end

  def generate
    resume = params[:resume]
    job_description = params[:job_description]

    openai_service = OpenaiService.new
    @cover_letter = openai_service.generate_highlighted_cover_letter(resume, job_description)

    respond_to do |format|
      format.html { render :new }
      format.json { render json: { cover_letter: @cover_letter.gsub("\n", "<br>") } }
    end
  end

  # POST /cover_letters or /cover_letters.json
  def create
    @cover_letter = CoverLetter.new(cover_letter_params)

    respond_to do |format|
      if @cover_letter.save
        format.html { redirect_to cover_letter_url(@cover_letter), notice: "Cover letter was successfully created." }
        format.json { render :show, status: :created, location: @cover_letter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cover_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cover_letters/1 or /cover_letters/1.json
  def update
    respond_to do |format|
      if @cover_letter.update(cover_letter_params)
        format.html { redirect_to cover_letter_url(@cover_letter), notice: "Cover letter was successfully updated." }
        format.json { render :show, status: :ok, location: @cover_letter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cover_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cover_letters/1 or /cover_letters/1.json
  def destroy
    @cover_letter.destroy!

    respond_to do |format|
      format.html { redirect_to cover_letters_url, notice: "Cover letter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cover_letter
      @cover_letter = CoverLetter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cover_letter_params
      params.require(:cover_letter).permit(:created_at, :updated_at, :user_id, :job_posting_id, :cover_letter_text)
    end
end
