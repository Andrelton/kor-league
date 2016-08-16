class UpdateController < ApplicationController
  def points
    redirect_to root_path
  end

  def goals
    databaser = Databaser.new

    databaser.update_goals_this_month
    databaser.update_owner_goals

    redirect_to root_path
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
end
