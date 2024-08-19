# <!-- app/controllers/cover_letters_controller.rb -->

class CoverLettersController < ApplicationController
  include Pundit::Authorization
  
  before_action :authenticate_user!
  before_action :set_cover_letter, only: %i[ show edit update destroy ]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @cover_letters = policy_scope(CoverLetter)
  end

  def show
    authorize @cover_letter
  end

  def new
    @cover_letter = CoverLetter.new
    authorize @cover_letter
  end

  def edit
    authorize @cover_letter
  end

  def create
    @cover_letter = CoverLetter.new(cover_letter_params)
    @cover_letter.user = current_user
    authorize @cover_letter

    if @cover_letter.save
      redirect_to @cover_letter, notice: 'Cover letter was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @cover_letter
    if @cover_letter.update(cover_letter_params)
      redirect_to @cover_letter, notice: 'Cover letter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @cover_letter
    @cover_letter.destroy
    redirect_to cover_letters_url, notice: 'Cover letter was successfully destroyed.'
  end

  private

  def set_cover_letter
    @cover_letter = CoverLetter.find(params[:id])
  end

  def cover_letter_params
    params.require(:cover_letter).permit(:cover_letter_text, :job_posting_id)
  end
end
