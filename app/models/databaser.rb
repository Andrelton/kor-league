class Databaser

  def create_club(attributes)
    club = Club.create(attributes)
    # assign pretty name to club
    club.name = PrettyClubName.find_by(fd_id: club.fd_id).name
    club.save
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

    # Create placeholder clubs for Spanish and Italian Leagues

  end

  def seed_pretty_club_names
    # retrieve club_name_conversions.txt with lines as nested arrays
    pretty_club_names = TextFileClient.new.get_club_name_conversions
    pretty_club_names.each do |club|
      # skip blank lines in text/csv file
      if club.any?
        PrettyClubName.create({
          fd_id: club[0],
          name: club[1]
        })
      end
    end
  end

  def assign_clubs_to_owners
    owner_clubs = TextFileClient.new.get_club_assignments
    owner_clubs.each do |owner_name, club_names|
      owner = Owner.find_by(name: owner_name)
      club_names.each do |club_name|
        club = Club.find_by(name: club_name)
        if club
          owner.clubs << club unless owner.clubs.includes(club)
        end
      end
    end
  end
end
