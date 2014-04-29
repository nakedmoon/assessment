class NumberToPhrasesController < ApplicationController


  def new
    @number_to_phrase = NumberToPhrase.new
  end

  def create
    @number_to_phrase = NumberToPhrase.new(number_to_phrase_params)

    respond_to do |format|
      if @number_to_phrase.save
        format.html { render 'spelled_number' }
        format.json { render :text => @number_to_phrase.to_json, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @number_to_phrase.errors, status: :unprocessable_entity }
      end
    end
  end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def number_to_phrase_params
      params[:number_to_phrase].permit(:number)
    end
end
