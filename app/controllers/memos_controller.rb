class MemosController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_message, only: [:edit, :update, :destroy]
  before_action :current_user, only: [:index, :edit, :update, :destroy]
  
  def index
    @memos = current_user.memos.all
    
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
    @memo = current_user.memos.find_by(id: params[:id])
    unless @memo
      flash[:danger] = 'メモが見つかりません。'
      redirect_to memos_path
    end
  end

  # Strong Parameter
  def memo_params
    params.require(:memo).permit(:title, :content)
  end
  
  def correct_user
    @memo = current_user.memos.find_by(id: params[:id])
    unless @memo
      redirect_to memos_url
    end
  end
end
