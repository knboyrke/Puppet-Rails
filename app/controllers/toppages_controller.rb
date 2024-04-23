class ToppagesController < ApplicationController
  def index
    if current_user
      redirect_to memos_path
    end
  end
end
