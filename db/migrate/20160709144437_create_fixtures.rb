class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.integer :home_club_id
      t.integer :away_club_id

      t.datetime :date

      t.timestamps null: false
    end
  end
end
