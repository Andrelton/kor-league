class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name

      t.string :email
      t.string :password_digest

      t.string :location
      t.text :about

      t.string :profile_pic

      t.timestamps null: false
    end
  end
end
