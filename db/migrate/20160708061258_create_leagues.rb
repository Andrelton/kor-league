class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.integer :fd_id
      t.string :fd_name

      t.string :name

      t.timestamps null: false
    end
  end
end
