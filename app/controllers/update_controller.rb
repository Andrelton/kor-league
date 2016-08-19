class UpdateController < ApplicationController
  def points
    databaser = Databaser.new

    databaser.update_clubs
    databaser.update_owner_ranks
    databaser.update_owner_goals_this_month

    redirect_to "/eric_console"
  end

  def goals
    databaser = Databaser.new

    databaser.update_club_goals_this_month

    redirect_to root_path
  end

  def champ
    TextFileClient.new.set_champ_name(params[:owner_name])

    redirect_to "/eric_console"
  end

  def avatar
    owner_id = params[:id]

    image = nil
    unless params[:restore]
      image = params[:image_url]
    end

    owner = Owner.find(owner_id)
    owner.avatar = image
    owner.save

    redirect_to owner_path(owner_id)
  end

  def avatar_list
    TextFileClient.new.update_avatar_list
    redirect_to "/eric_console"
  end

  def special

    redirect_to root_path
  end

end
