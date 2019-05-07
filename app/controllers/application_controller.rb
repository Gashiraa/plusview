class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session
  before_action :authenticate_user!
end
