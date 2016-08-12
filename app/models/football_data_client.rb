require 'dotenv'
Dotenv.load

class FootballDataClient
  include HTTParty
  base_uri "http://api.football-data.org"

  COUNTRIES = {
      england: 426,
      germany: 430,
      spain: 436,
      italy: 438
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
    fixtures_data = []

    COUNTRIES.each do |_, country_number|
     country_fixtures = self.class.get(
      "/v1/soccerseasons/#{country_number}/fixtures",
      headers: @headers
      )
     fixtures_data += country_fixtures["fixtures"]
    end

    return fixtures_data
  end

end
