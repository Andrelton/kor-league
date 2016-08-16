class Fixture < ActiveRecord::Base
  attr_reader :home_club, :away_club, :home_owner, :away_owner

  def self.inter_league_fixtures
    future_fixtures = self.where("date > ?", DateTime.now).sort_by { |fixture| fixture.date }
    inter_league_fixtures = []
    future_fixtures.each do |fixture|
      fixture.set_club_instance_variables
      if fixture.has_two_owners?
        inter_league_fixtures << fixture
      end
      break if inter_league_fixtures.length == 15
    end

    return inter_league_fixtures
  end

  def set_club_instance_variables
    @home_club = Club.find_by(fd_id: self.home_club_id)
    @away_club = Club.find_by(fd_id: self.away_club_id)
  end

  def has_two_owners?
    home_owners_collection = @home_club.owners
    if home_owners_collection.any?
      @home_owner = home_owners_collection.first
    else
      return false
    end

    away_owners_collection = @away_club.owners
    if away_owners_collection.any?
      @away_owner = away_owners_collection.first
    else
      return false
    end

    return true
  end

end
