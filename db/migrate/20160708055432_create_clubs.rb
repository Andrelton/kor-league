class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.references :league, index: true, foreign_key: true

      t.integer :fd_id
      t.string :fd_name

      t.string :name
      t.string :crest_url

      t.timestamps null: false
    end
  end
end
