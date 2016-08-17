class Owner < ActiveRecord::Base
  has_many :owner_clubs
  has_many :clubs, through: :owner_clubs, source: :club

  attr_accessor :head_rank, :goal_rank

  # --- CLASS METHODS ---
  def self.ranked_by_heads
    ranked_owners = Owner.all.sort_by { |owner| owner.heads.count }.reverse!

    previous_owner_head_count = nil
    previous_owner_rank = nil

    ranked_owners.each_with_index do |owner, index|
      if owner.heads.count == previous_owner_head_count
        owner.head_rank = previous_owner_rank
      else
        previous_owner_head_count = owner.heads.count
        previous_owner_rank = index + 1
        owner.head_rank = previous_owner_rank
      end
    end
  end

  def self.ranked_by_goals
    ranked_owners = Owner.order(goals_this_month: :desc)

    previous_owner_goals = nil
    previous_owner_rank = nil

    ranked_owners.each_with_index do |owner, index|
      if owner.goals_this_month == previous_owner_goals
        owner.goal_rank = previous_owner_rank
      else
        previous_owner_goals = owner.goals_this_month
        previous_owner_rank = index + 1
        owner.goal_rank = previous_owner_rank
      end
    end

  end


  # --- INSTANCE METHODS ---
  def heads
    heads = []
    self.clubs.each do |club|
      heads = heads + club.heads
    end

    return heads
  end

  def points
    points = 0
    self.clubs.each do |club|
      points += club.points || 0
    end
    return points
  end
end
