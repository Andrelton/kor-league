class CreatePrettyClubNames < ActiveRecord::Migration
  def change
    create_table :pretty_club_names do |t|
      t.integer :fd_id
      t.string :name

      t.timestamps null: false
    end
  end
end
