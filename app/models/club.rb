class Club < ActiveRecord::Base
  belongs_to :league

  # add validations
end
