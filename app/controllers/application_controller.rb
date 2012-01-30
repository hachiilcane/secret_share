class ApplicationController < ActionController::Base
  protect_from_forgery

  USERNAME = "owner"
  PASSWORD = "xxxx"

  before_filter :authenticate

  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      (@name = name) == USERNAME && password == PASSWORD
    end
  end
end
