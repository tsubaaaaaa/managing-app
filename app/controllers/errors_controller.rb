class ErrorsController < ApplicationController
  def internal_server_error
    render "errors/internal_server_error", status: :internal_server_error
  end
end
