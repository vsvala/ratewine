class Membership < ApplicationRecord
  belongs_to :wine_club # jäsenyys kuuluu aina yhteen clubiin
  belongs_to :user
end
