class ApplicationController < ActionController::Base
  protect_from_forgery with: nil
  
  def basic_auth
    authenticate_or_request_with_http_basic do |user, pass|
      user == Rails.application.credentials.basic_user && pass == Rails.application.credentials.basic_password
    end
  end
end
