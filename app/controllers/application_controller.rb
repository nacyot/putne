class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #protect_from_forgery with: :exception

  protect_from_forgery with: :null_session
  around_filter :global_request_logging
  skip_before_filter  :verify_authenticity_token

  def global_request_logging
    logger.info "USERAGENT: #{request.headers['HTTP_USER_AGENT']}"
    begin
      yield
    ensure
      logger.info "response_status: #{response.status}"
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/", :alert => exception.message
  end
end
