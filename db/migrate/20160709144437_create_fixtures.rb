class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.integer :home_team_id
      t.integer :away_team_id

      t.datetime :date

      t.timestamps null: false
    end
  end
end
