class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :update_owner_ranks

  def update_owner_ranks
    owners = Owner.all
    ranked_owners = owners.sort_by { |owner| owner.points }.reverse!

    previous_owner_points = nil
    previous_owner_rank = nil

    ranked_owners.each_with_index do |owner, index|
      if owner.points == previous_owner_points
        owner.rank = previous_owner_rank
      else
        previous_owner_points = owner.points
        previous_owner_rank = index + 1
        owner.rank = previous_owner_rank
      end
      owner.save
    end
  end

  def update_goals


  end

end
