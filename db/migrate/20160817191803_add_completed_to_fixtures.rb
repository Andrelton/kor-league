class AddCompletedToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :completed, :boolean, default: false
  end
end
