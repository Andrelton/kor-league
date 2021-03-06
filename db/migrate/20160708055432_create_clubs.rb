class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.references :country, index: true, foreign_key: true

      t.integer :fd_id
      t.string :fd_name

      t.string :name
      t.string :crest_url

      t.integer :points
      t.integer :played

      t.timestamps null: false
    end
  end
end
