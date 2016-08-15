class AddRankToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :rank, :integer
  end
end
