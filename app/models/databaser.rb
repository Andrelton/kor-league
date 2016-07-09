class Databaser
  def get_club_fd_id(url)
    url.split("/").last
  end

  def create_club(attributes)
    club = Club.new(attributes)
    # assign pretty name to club as "name"
    club.name = PrettyClubName.find_by(fd_id: club.fd_id).name
    club.save
  end

  def seed_clubs
    fd_client = FootballDataClient.new
    all_teams = fd_client.get_all_teams

    all_teams.each do |team|
      club_attributes = {
        # ! country: ,
        fd_id: get_club_fd_id(team["_links"]["team"]["href"]),
        fd_name: team["teamName"],
        name: "TEST",
        crest_url: team["crestURI"],
        points: team["points"],
        played: team["playedGames"]
      }
      create_club(club_attributes)
    end

    # Create placeholder clubs for Spanish and Italian Leagues
    placeholder_clubs = TextFileClient.new.get_placeholder_clubs
    placeholder_clubs.each do |club_name|
      Club.create(name: club_name)
    end
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
          owner.clubs << club unless owner.clubs.include?(club)
        end
      end
    end
  end

  def create_fixture(attributes)
    Fixture.create(attributes)
  end

  def seed_fixtures
    fd_client = FootballDataClient.new
    fixtures = fd_client.get_all_fixtures

    fixtures.each do |fixture|
      fixture_attributes = {
        home_club_id: get_club_fd_id(fixture["_links"]["homeTeam"]["href"]),
        away_club_id: get_club_fd_id(fixture["_links"]["awayTeam"]["href"]),
        date: fixture["date"]
      }
      create_fixture(fixture_attributes)
    end
  end
end
