require 'dotenv'
Dotenv.load

class FootballDataClient
  include HTTParty
  base_uri "http://api.football-data.org"

  def initialize
    @api_key = ENV['FOOTBALL_DATA_API_KEY']
    @headers = { "X-Auth-Token" => @api_key}
  end

  def get_german_data
     euro_data = self.class.get(
      "/v1/soccerseasons/424/leagueTable",
      headers: @headers
      )
  end

  def key_test
    ENV['FOOTBALL_DATA_API_KEY']
  end
end
