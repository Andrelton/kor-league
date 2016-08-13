class AddAvatarToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :avatar, :string
  end
end
