class Club < ActiveRecord::Base
  belongs_to :country

  has_many :owner_clubs
  has_many :owners, through: :owner_clubs, source: :owner

  validates :name, uniqueness: true
  # add validations
end
