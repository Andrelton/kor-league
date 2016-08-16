class AddGoalsThisMonthToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :goals_this_month, :integer
  end
end
