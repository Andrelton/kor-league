class WelcomeController < ApplicationController
  def index
    # Horrible work-around for new Man City crest
    man_city = Club.find_by(fd_id: 65)
    man_city.crest_url = "https://upload.wikimedia.org/wikipedia/en/e/eb/Manchester_City_FC_badge.svg"
    man_city.save

    @owners = Owner.all

    data_client = FootballDataClient.new
    @key = data_client.key_test

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
end
