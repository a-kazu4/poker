class TopController < ApplicationController

  def new
    @hands = CardForm.new
  end

  def judge
    @hands = CardForm.new(params[:hands])
    redirect_to top_url
    flash[:hoge] = '改行したい<br>改行できた<br>やったー!'
    flash[:hogehoge] = "Successfully created..."
  end
end

