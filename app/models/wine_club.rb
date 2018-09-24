class WineClub < ApplicationRecord
  has_many :membership, dependent: :destroy
  has_many :user, through: :memberships, source: :user

  def to_s
    "#{name}, #{city}"
  end
end
