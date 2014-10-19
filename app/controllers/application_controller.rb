class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    profile_path(resource)
  end

  # Thrown when a resource that doesn't exist is accessed
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, :alert => "We couldn't find what you were looking for."
  end


  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end
