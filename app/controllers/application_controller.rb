class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :update_owner_ranks

  def update_owner_ranks
    owners = Owner.all
    ranked_owners = owners.sort_by { |owner| [owner.points, owner.name] }.reverse!
    ranked_owners.each_with_index do |owner, index|
      owner.rank = index + 1
      owner.save
    end
  end

end
