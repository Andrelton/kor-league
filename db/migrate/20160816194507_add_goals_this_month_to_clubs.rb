class AddGoalsThisMonthToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :goals_this_month, :integer
  end
end
