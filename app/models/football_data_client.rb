require 'dotenv'
Dotenv.load

class FootballDataClient
  include HTTParty
  base_uri "http://api.football-data.org"

  COUNTRIES = {
      english: 426,
      german: 430,
      spanish: 436,
      italian: 438
    }

  def initialize
    @api_key = ENV['FOOTBALL_DATA_API_KEY']
    @headers = { "X-Auth-Token" => @api_key}
  end

  def key_test
    ENV['FOOTBALL_DATA_API_KEY']
  end

  def get_all_teams
    team_data = []

    COUNTRIES.each do |_, country_number|
     country_teams = self.class.get(
      "/v1/soccerseasons/#{country_number}/leagueTable",
      headers: @headers
      )
     team_data += country_teams["standing"]
    end

    return team_data
  end

  def get_all_fixtures
    fixture_hashes = []

    COUNTRIES.each do |_, country_number|
     country_fixtures = self.class.get(
      "/v1/soccerseasons/#{country_number}/fixtures",
      headers: @headers
      )
     fixture_hashes += country_fixtures["fixtures"]
    end

    return fixture_hashes
  end

  def get_club_fd_id(url_string)
    url_string.split("/").last
  end

  def create_temp_fixture(fixture_hash)
    home_team_url_string = fixture_hash["_links"]["homeTeam"]["href"]
    away_team_url_string = fixture_hash["_links"]["awayTeam"]["href"]

    return Fixture.new({
      home_club_id: get_club_fd_id(home_team_url_string),
      away_club_id: get_club_fd_id(away_team_url_string),
      home_club_goals: fixture_hash["result"]["goalsHomeTeam"],
      away_club_goals: fixture_hash["result"]["goalsAwayTeam"],
      date: fixture_hash["date"]
    })
  end

  def get_fixture_updates
    completed_temp_fixtures = []
    timed_temp_fixtures = []

    fixture_hashes =  self.get_all_fixtures
    fixture_hashes.each do |fixture_hash|

      status = fixture_hash["status"]

      # If only the most recent fixtures are desired:
      # fixture_date = DateTime.parse(fixture_hash["date"])
      # && fixture_date > (DateTime.now - 2.weeks)
      if status == "FINISHED"
        completed_temp_fixtures << create_temp_fixture(fixture_hash)
      end
      if status == "TIMED" || status == "SCHEDULED"
        fixture_date = DateTime.parse(fixture_hash["date"])
        if fixture_date < (DateTime.now + 1.month)
          timed_temp_fixtures << create_temp_fixture(fixture_hash)
        end
      end
    end

    return {
      completed: completed_temp_fixtures,
      timed: timed_temp_fixtures
    }
  end

  def get_league_updated_times
    league_updated_times = {}
    leagues = self.class.get(
        "/v1/soccerseasons",
        headers: @headers
      )
    leagues.each do |league|
      if COUNTRIES.values.include?(league["id"])
        league_name = COUNTRIES.key(league["id"])
        league_updated_times[league_name] = DateTime.parse(league["lastUpdated"])
      end
    end

    return league_updated_times.sort_by { |_, date| date }.reverse
  end

  def test
    fixtures_data = self.class.get(
      "/v1/soccerseasons/426/fixtures",
      headers: @headers
      )
    first_fixture = fixtures_data["fixtures"].first
    # binding.pry
    return first_fixture
  end

end
