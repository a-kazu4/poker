class TopController < ApplicationController
  def index

  end

  def create
    redirect_to top_index_url
    flash[:hoge] = '改行したい<br>改行できた<br>やったー!'
    flash[:hogehoge] = "Successfully created..."
  end
end
