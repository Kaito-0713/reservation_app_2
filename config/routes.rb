Rails.application.routes.draw do
  get 'facilities/index'
  get 'facilities/show'
  get 'facilities/new'
  get 'facilities/edit'
  devise_for :users

  # 部屋(Room) … 検索ページあり、予約をネスト
  resources :rooms do
    collection do
      get :search   # /rooms/search
    end
    resources :reservations, only: [:new, :create, :destroy, :show, :index, :edit, :update]
  end

  # 自分が予約した一覧
  resources :reservations, only: [:index, :show, :destroy]

  resources :facilities

  # マイページ（current_user 専用）
  resource :user, only: [:show, :edit, :update]

  # root
  root "rooms#index"
end

