class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Deviseのストロングパラメータ設定
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ時
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :icon_image])
    
    # アカウント編集時
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :icon_image])
  end
end

