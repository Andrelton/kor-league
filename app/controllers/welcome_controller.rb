class WelcomeController < ApplicationController
  def index
    @owners = Owner.all

    data_client = FootballDataClient.new
    @key = data_client.key_test

    render :index
  end

  def create_clubs
    Databaser.new.seed_clubs
    render
  end
end
