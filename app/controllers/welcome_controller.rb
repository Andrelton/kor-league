class WelcomeController < ApplicationController
  def index
    @owners = Owner.all

    data_client = FootballDataClient.new
    @key = data_client.key_test

    render :index
  end

  def create_club_data
    databaser = Databaser.new

    databaser.seed_pretty_club_names
    databaser.seed_clubs
    # Owner.first.clubs << Club.first
  end
end
