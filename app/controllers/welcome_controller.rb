class WelcomeController < ApplicationController
  def index
    @owners = Owner.all

    @key = FootballDataClient.new.key_test
    render :index
  end
end
