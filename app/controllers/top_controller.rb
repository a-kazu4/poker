class TopController < ApplicationController

  def new
    @hands = CardForm.new
  end

  def judge
    array_hands = card_form_params[:hands].split(' ')
    @hands = CardForm.new(array_hands)

    error_messages = @hands.valid?
    error_messages.each_with_index {|message, i| flash[i] = message }

    flash[:hands] = @hands.check_hands

    redirect_to top_url
  end

  private
  def card_form_params
    params.require(:card_form).permit(:hands)
  end
end

