class User < ApplicationRecord
    has_many :ratings   # käyttäjällä on monta ratingia
end

class Rating < ApplicationRecord
  belongs_to :wine
  belongs_to :user   # rating kuuluu myös käyttäjään

  def to_s
    "#{wine.name} #{score}"
  end
end