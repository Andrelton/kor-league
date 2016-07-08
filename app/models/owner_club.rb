class OwnerClub < ActiveRecord::Base
  belongs_to :owner
  belongs_to :club

  validates :owner_id, uniqueness: { scope: :club_id }
end
