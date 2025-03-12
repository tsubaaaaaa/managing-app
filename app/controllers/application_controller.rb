class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :render_500

  private

  def render_500(exception)
    Rails.logger.error(exception.message) # ログにエラーを出力
    Rails.logger.error(exception.backtrace.join("\n")) # 詳細ログ

    redirect_to "/500"
  end
end
