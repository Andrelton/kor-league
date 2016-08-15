class WelcomeController < ApplicationController
  def index
    @owners = Owner.order(:rank)
    render :index
  end

  def owners
    @owner = Owner.find(params[:id])
    render :owner_page
  end

  def create_club_data
    # databaser = Databaser.new

    # databaser.seed_pretty_club_names
    # databaser.seed_clubs
    # databaser.assign_clubs_to_owners
    # databaser.seed_fixtures
  end

  def eric_console
    @avatar_list = TextFileClient.new.read_avatar_list
    render :eric_console
  end
end
