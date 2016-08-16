class AddGoalsToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :home_club_goals, :integer
    add_column :fixtures, :away_club_goals, :integer
  end
end
