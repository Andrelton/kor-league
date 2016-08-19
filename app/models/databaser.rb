class Databaser
  # *** SEED DATABASE ***
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
    all_teams = FootballDataClient.new.get_all_teams

    all_teams.each do |team|
      club_attributes = {
        # ! country: ,
        fd_id: get_club_fd_id(team["_links"]["team"]["href"]),
        fd_name: team["teamName"],
        crest_url: team["crestURI"],
        points: team["points"],
        played: team["playedGames"]
      }
      create_club(club_attributes)
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
      if fixture["status"] == "FINISHED"
        fixture_attributes[:completed] = true
        fixture_attributes[:home_club_goals] = fixture["result"]["goalsHomeTeam"]
        fixture_attributes[:away_club_goals] = fixture["result"]["goalsAwayTeam"]
      end
      create_fixture(fixture_attributes)
    end
  end


  # *** UPDATE DATABASE ***
    def update_clubs
    # Updates from API League Table
    all_teams = FootballDataClient.new.get_all_teams

    # a 'team' is a nested hash of club data taken from
    # the league table referenced above
    all_teams.each do |team|
      team_fd_id = get_club_fd_id(team["_links"]["team"]["href"])
      club = Club.find_by(fd_id: team_fd_id)

      club.points = team["points"]
      club.played = team["played"]

      # REMOVE IF SWITCHING GOAL COUNTING TO
      club.goals_this_month = team["goals"]

      club.save
    end
  end

   def update_owner_ranks
    owners = Owner.all
    ranked_owners = owners.sort_by { |owner| owner.points }.reverse!

    previous_owner_points = nil
    previous_owner_rank = nil

    ranked_owners.each_with_index do |owner, index|
      if owner.points == previous_owner_points
        owner.rank = previous_owner_rank
      else
        previous_owner_points = owner.points
        previous_owner_rank = index + 1
        owner.rank = previous_owner_rank
      end
      owner.save
    end
  end

  def update_owner_goals_this_month
    Owner.all.each do |owner|
      owner_goals_this_month = 0
      owner.clubs.each do |club|
        if club.goals_this_month
          owner_goals_this_month += club.goals_this_month
        end
      end
      owner.goals_this_month = owner_goals_this_month
      owner.save
    end
  end

  def update_fixtures
    all_fixtures = FootballDataClient.new.get_all_fixtures
  end

  # !!! THIS CALCULATES GOALS FROM FIXTURES, MORE SLOWLY !!!
  # def update_club_goals_this_month
  #   # Retrieves fixtures between the start of the month and today's date
  #   completed_fixtures_this_month = Fixture.get_completed_fixtures_this_month

  #   # Hash that will contain {fd_id: (goals scored in this month)}
  #   clubs_and_goals_scored = Hash.new(0)

  #   # Assembles a running total of goals scored this month
  #   completed_fixtures_this_month.each do |fixture|
  #     clubs_and_goals_scored[fixture.home_club_id] += fixture.home_club_goals
  #     clubs_and_goals_scored[fixture.away_club_id] += fixture.away_club_goals
  #   end

  #   # Sets each club's 'goals_this_month' according to hash, above
  #   clubs_and_goals_scored.each do |fd_id, goals|
  #     club = Club.find_by(fd_id: fd_id)
  #     club.goals_this_month = clubs_and_goals_scored[fd_id]
  #     club.save
  #   end
  # end



end
