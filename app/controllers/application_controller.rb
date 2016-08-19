class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # EXAMPLE
  # This would be run before every controller action
  # before_filter :update_owner_ranks

  # def update_owner_ranks
  #   ...
  # end

end
