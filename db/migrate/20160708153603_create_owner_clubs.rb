class CreateOwnerClubs < ActiveRecord::Migration
  def change
    create_table :owner_clubs do |t|
      t.references :owner, index: true
      t.references :club, index: true

      t.timestamps null: false
    end
  end
end
