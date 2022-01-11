class ApplicationController < ActionController::Base
  # for testing purpuses only, should be removed for production
  protect_from_forgery with: :null_session
end
