class WelcomeController < ApplicationController
  def index
    @owners = Owner.order(:rank, :name)
    render :index
  end

  def owners
    @owner = Owner.find(params[:id])
    render :owner_page
  end

  def fixtures
    @fixtures = Fixture.inter_league_fixtures
    render :fixtures
  end

  def eric_console
    @avatar_list = TextFileClient.new.read_avatar_list
    render :eric_console
  end
end
