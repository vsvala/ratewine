class User < ApplicationRecord
  include RatingAverage
  has_many :ratings   # käyttäjällä on monta ratingia
end
