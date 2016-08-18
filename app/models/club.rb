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
    next_fixture = Fixture.where("date > ?", DateTime.now)
      .where("home_club_id = ? or away_club_id = ?", self.fd_id, self.fd_id)
      .order(:date).first

    next_fixture = Fixture.where("date > ?", DateTime.now)
      .where("home_club_id = ? or away_club_id = ?", self.fd_id, self.fd_id)
      .order(:date).first

    opponent = nil
    if next_fixture.home_club_id == self.fd_id
      opponent = Club.find_by(fd_id: next_fixture.away_club_id)
    else
      opponent = Club.find_by(fd_id: next_fixture.home_club_id)
    end

    @next_fixture = { date: next_fixture.date, opponent: opponent }
  end

  def next_fixture
    @next_fixture || get_next_fixture
  end
end
