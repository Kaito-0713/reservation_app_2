class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  private

  def user_params
    # name と avatar を許可
    params.require(:user).permit(:name, :avatar)
  end
end
