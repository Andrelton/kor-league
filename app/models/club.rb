class Club < ActiveRecord::Base
  belongs_to :country

  has_many :owner_clubs
  has_many :owners, through: :owner_clubs, source: :owner

  validates :name, uniqueness: true

  def get_completed_fixtures
    return Fixture.where(completed: true).where("home_club_id = ? or away_club_id = ?", self.fd_id, self.fd_id)
  end

  def heads
    completed_fixtures = self.get_completed_fixtures

    heads = []
    completed_fixtures.each do |fixture|
      if fixture.winning_club == self && fixture.losing_club.owners.any?
        heads << fixture
      end
    end

    return heads
  end

  def get_fixtures(number = 1)

  end

  def get_next_fixture
    # The next fixture after the time 2 hours ago, to include live matches
    next_fixture = Fixture.where("date > ?", DateTime.now - 2.hours)
      .where("home_club_id = ? or away_club_id = ?", self.fd_id, self.fd_id)
      .order(:date).first

    # if the fixture is before now (i.e. already started)...
    if next_fixture.date < DateTime.now
      next_fixture.live = true
    end

    opponent = nil
    if next_fixture.home_club_id == self.fd_id
      next_fixture.opponent = Club.find_by(fd_id: next_fixture.away_club_id)
    else
      next_fixture.opponent = Club.find_by(fd_id: next_fixture.home_club_id)
    end

    return next_fixture
  end

  def next_fixture
    @next_fixture ||= get_next_fixture
  end
end
