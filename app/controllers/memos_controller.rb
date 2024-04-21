class MemosController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_message, only: [:edit, :update, :destroy]
  
  def index
    @memos = Memo.all
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = current_user.memos.build(memo_params)

    if @memo.save
      redirect_to memos_path
    else
      flash.now[:danger] = 'ノートの作成に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @memo.update(memo_params)
      redirect_to memos_path
    else
      flash.now[:danger] = 'ノートの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @memo.destroy

    flash[:success] = 'ノートを削除しました'
    redirect_to memos_url
  end
  
  private

  def set_message
    @memo = Memo.find(params[:id])
  end

  # Strong Parameter
  def memo_params
    params.require(:memo).permit(:title, :content)
  end
end
