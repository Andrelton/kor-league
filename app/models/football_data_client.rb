require 'dotenv'
Dotenv.load

class FootballDataClient
  include HTTParty
  base_uri "http://api.football-data.org"

  def initialize
    @api_key = ENV['FOOTBALL_DATA_API_KEY']
    @headers = { "X-Auth-Token" => @api_key}
  end

  def key_test
    ENV['FOOTBALL_DATA_API_KEY']
  end

  def get_all_teams
    countries = {
      england: 426,
      germany: 430
    }

    team_data = []

    countries.each do |_, country_number|
     country_teams = self.class.get(
      "/v1/soccerseasons/#{country_number}/leagueTable",
      headers: @headers
      )
     team_data += country_teams["standing"]
    end

    return team_data
  end


end
