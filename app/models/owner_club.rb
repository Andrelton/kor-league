class OwnerClub < ActiveRecord::Base
  belongs_to :owner
  belongs_to :club
end
