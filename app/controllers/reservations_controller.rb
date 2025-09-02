class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, except: [:index, :show, :destroy]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :authorize_reservation!, only: [:edit, :update, :destroy]

  def index
    @reservations = current_user.reservations.includes(:room).order(start_date: :desc)
  end

  def new
    @reservation = @room.reservations.new
  end

  def create
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to [@room, @reservation], notice: "予約を完了しました。"
    else
      flash.now[:alert] = "予約に失敗しました。入力内容をご確認ください。"
      render :new
    end
  end

  def show
    @room = @reservation.room
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to [@room, @reservation], notice: "予約を更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。入力内容をご確認ください。"
      render :edit
    end
  end

 def destroy
    if @reservation.user == current_user
      @reservation.destroy
      redirect_to reservations_path, notice: "予約をキャンセルしました。"
    else
      redirect_to reservations_path, alert: "権限がありません。"
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def authorize_reservation!
    unless @reservation.user == current_user
      redirect_to root_path, alert: "権限がありません。"
    end
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :number_of_people)
  end
end
