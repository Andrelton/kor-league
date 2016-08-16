class Owner < ActiveRecord::Base
  has_many :owner_clubs
  has_many :clubs, through: :owner_clubs, source: :club

  def self.ranked_by_goals
    Owner.order(goals_this_month: :desc)
  end

  def points
    points = 0
    self.clubs.each do |club|
      points += club.points || 0
    end
    return points
  end
end
