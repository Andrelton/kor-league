class WelcomeController < ApplicationController
  def index
    @owners = Owner.order(:rank, :name)
    render :index
  end

  # By convention, this should be #show...
  def owners
    @owner = Owner.find(params[:id])
    render :owner_page
  end

  def async_fixtures
    inter_league_fixtures = Fixture.get_future_inter_league_fixtures_by_owner(params[:owner_id], 5)
    render partial: "dashboard_fixtures", locals: { inter_league_fixtures: inter_league_fixtures}
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

    render :test
  end

  def eric_console
    @updates = FootballDataClient.new.get_league_updated_times
    @owners = Owner.all
    @avatar_list = TextFileClient.new.read_avatar_list
    render :eric_console
  end
end
