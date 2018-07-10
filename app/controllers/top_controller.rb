class TopController < ApplicationController
  include CardHelper

  def new
    @card_form = CardForm.new
  end

  def judge
    array_hands = card_form_params[:hands].split
    @card_form = CardForm.new(array_hands)

    error_messages = @card_form.valid?

    if error_messages.empty?
      flash[:hands] = CardHelper::HAND_NAME[@card_form.check_hands]
      return redirect_to top_url
    else
      error_messages.each_with_index {|message, i| flash[i] = message }
      flash.now[:errors] = error_messages

      return render :new
    end
  end

  private
  def card_form_params
    params.require(:card_form).permit(:hands)
  end
end

