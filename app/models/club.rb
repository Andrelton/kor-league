class Club < ActiveRecord::Base
  belongs_to :country

  has_many :owner_clubs
  has_many :owners, through: :owner_clubs, source: :owner
  # add validations
end
