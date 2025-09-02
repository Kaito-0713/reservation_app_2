class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_room, only: %i[show edit update destroy]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: "部屋を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "部屋情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url, notice: "部屋を削除しました。"
  end

  def search
  # 検索条件に応じて取得、例として全件取得
  search_word = params[:q]
  @rooms = if search_word.present?
             Room.where("name LIKE ?", "%#{search_word}%")
           else
             Room.all
           end
end

 private

 def set_room
   @room= Room.find(params[:id])
 end

 def room_params
   params.require(:room).permit(:name, :detail, :price, :address)
 end
end
