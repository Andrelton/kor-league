class Databaser

  def create_club(attributes)
    Club.create(attributes)
    # p attributes
  end

  def get_club_fd_id(links)
    url = links["team"]["href"]
    url.split("/").last
  end

  def seed_clubs
    fb_data_client = FootballDataClient.new
    all_teams = fb_data_client.get_all_teams

    all_teams.each do |team|
      club_attributes = {
        # ! country: ,
        fd_id: get_club_fd_id(team["_links"]),
        fd_name: team["teamName"],
        name: "TEST",
        crest_url: team["crestURI"],
        points: team["points"],
        played: team["playedGames"]
      }
      create_club(club_attributes)
    end
  end

  def assign_clubs_to_owners

  end
end
