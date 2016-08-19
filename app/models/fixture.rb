class Fixture < ActiveRecord::Base
  attr_reader :home_club, :away_club, :home_owner, :away_owner
  attr_accessor :opponent, :opp_owner, :live

  after_initialize :set_club_instance_variables

  def set_club_instance_variables
    @home_club = Club.find_by(fd_id: self.home_club_id)
    @away_club = Club.find_by(fd_id: self.away_club_id)
  end

  # --- CLASS METHODS ---
  def self.get_completed_fixtures
    return self.where("date < ?", DateTime.now).order(:date)
  end

  def self.get_completed_fixtures_this_month
    # Starting in October:
    # start_of_month = DateTime.now.strftime('%Y-%m-01')
    # start_date = DateTime.parse(start_of_month)

    start_date = DateTime.parse("2016-08-01")
    return self.where("date > ?", start_date)
                                              .where("date < ?", DateTime.now).order(:date)
  end

  def self.get_future_fixtures
    return self.where("date > ?", DateTime.now - 2.hours).order(:date)
  end

  def self.get_completed_inter_league_fixtures(count = nil)
    completed_fixtures = self.get_completed_fixtures
    return self.find_inter_league_fixtures(completed_fixtures, count)
  end

  def self.get_future_inter_league_fixtures(count = nil)
    future_fixtures = self.get_future_fixtures
    return self.find_inter_league_fixtures(future_fixtures, count)
  end

  def self.find_inter_league_fixtures(fixtures, count = nil)
    inter_league_fixtures = []
    fixtures.each do |fixture|
      fixture.set_owners
      inter_league_fixtures << fixture if fixture.has_two_owners?
      break if count && inter_league_fixtures.length == count
    end
    return inter_league_fixtures
  end

  def self.get_future_inter_league_fixtures_by_owner(owner_id, count)
    owner_clubs_fd_ids = Owner.find(owner_id).clubs.map(&:fd_id)

    all_future_inter_league_fixures = self.get_future_inter_league_fixtures(35)

    owner_future_inter_league_fixtures = []
    all_future_inter_league_fixures.each do |fixture|
      if owner_clubs_fd_ids.include?(fixture.home_club_id)
        fixture.opp_owner = fixture.away_owner
        owner_future_inter_league_fixtures << fixture
      end
      if owner_clubs_fd_ids.include?(fixture.away_club_id)
        fixture.opp_owner = fixture.home_owner
        owner_future_inter_league_fixtures << fixture
      end
      break if owner_future_inter_league_fixtures.count == count
    end

    return owner_future_inter_league_fixtures
  end

  # --- INSTANCE METHODS ---
  def set_owners
    @home_owner = self.home_club.owners.first
    @away_owner = self.away_club.owners.first
  end

  def winning_club
    return nil unless self.completed
    if self.home_club_goals > self.away_club_goals
      return self.home_club
    elsif self.away_club_goals > self.home_club_goals
      return self.away_club
    else
      return nil
    end
  end

  def losing_club
      if self.winning_club
        return self.winning_club == self.home_club ? self.away_club : self.home_club
      else
        return nil
      end
  end

  def has_two_owners?
    if self.away_owner && self.home_owner
      return true
    else
      return false
    end
  end

end
