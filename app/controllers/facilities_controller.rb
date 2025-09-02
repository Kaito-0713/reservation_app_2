class FacilitiesController < ApplicationController
  before_action :authenticate_user!  # ログイン必須
  before_action :set_facility, only: [:show, :edit, :update, :destroy]
  before_action :authorize_facility, only: [:show, :edit, :update, :destroy] # show も制限するなら追加

  def index
    # 自分が登録した施設だけ表示
    @facilities = current_user.facilities
  end

  def show
  end

  def new
    @facility = current_user.facilities.build
  end

  def create
    @facility = current_user.facilities.build(facility_params)  # ← 登録者を紐付け

    if @facility.save
      redirect_to @facility, notice: "施設を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @facility.update(facility_params)
      redirect_to @facility, notice: "施設を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @facility.destroy
    redirect_to facilities_path, notice: "施設を削除しました"
  end

  private

  def set_facility
    @facility = current_user.facilities.find(params[:id])
  end

  def facility_params
    params.require(:facility).permit(:name, :address, :description)
  end

  def authorize_facility
    unless @facility.user == current_user
      redirect_to facilities_path, alert: "権限がありません"
    end
  end
end
