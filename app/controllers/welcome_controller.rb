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
    @fixtures = Fixture.get_future_inter_league_fixtures(15)
    render :fixtures
  end

  def sidebets
    @owners_by_heads = Owner.ranked_by_heads
    @owners_by_goals = Owner.ranked_by_goals
  end

  def test
    # FootballDataClient.new.test
    @owners = Owner.ranked_by_heads
    render :test
  end

  def eric_console
    @owners = Owner.all
    @avatar_list = TextFileClient.new.read_avatar_list
    render :eric_console
  end
end
