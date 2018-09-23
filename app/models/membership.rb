class Membership < ApplicationRecord
  belongs_to :wine_club #jäsenyys kuuluu aina yhteen clubiin
  has_many :users, through: :wine_club #jäsenyyteen liittyy useita jäseniä
end
