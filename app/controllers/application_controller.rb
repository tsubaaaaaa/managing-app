class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :render_500

  before_action :authenticate_user!, except:[:read_only]

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
  end

  private

  def render_500(exception)
    Rails.logger.error(exception.message) # ログにエラーを出力
    Rails.logger.error(exception.backtrace.join("\n")) # 詳細ログ

    redirect_to "/500"
  end


end
