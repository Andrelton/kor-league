class Club < ActiveRecord::Base
  belongs_to :country

  has_many :owner_clubs
  has_many :owners, through: :owner_clubs, source: :owner

  validates :name, uniqueness: true

  # OLD CODE
  # def next_fixture
  #   # Test code; substitute 'future_date' for 'date' below
  #   # future_date = DateTime.now + 3.months
  #   return false unless self.fd_id

  #   next_fixture = Fixture.where("date > ?", DateTime.now).where("home_club_id = ? or away_club_id = ?", self.fd_id, self.fd_id).order(:date).first

  #   opponent = nil
  #   if next_fixture.home_club_id == self.fd_id
  #     opponent = Club.find_by(fd_id: next_fixture.away_club_id)
  #   else
  #     opponent = Club.find_by(fd_id: next_fixture.home_club_id)
  #   end

  #   return { date: next_fixture.date, opponent: opponent }
  # end

  def get_next_fixture
    # Test code; substitute 'future_date' for 'date' below
    # future_date = DateTime.now + 3.months
    # return false unless self.fd_id

    next_fixture = Fixture.where("date > ?", DateTime.now).where("home_club_id = ? or away_club_id = ?", self.fd_id, self.fd_id).order(:date).first

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
