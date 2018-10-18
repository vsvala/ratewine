class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :wine_club # jäsenyys kuuluu aina yhteen clubiin

  validates :wine_club, uniqueness: {
    scope: :user,
    message: "you are already a member!"
  }

  scope :confirmed, -> { where confirm: true }
  scope :notconfirmed, -> { where confirm: [nil, false] }
end
