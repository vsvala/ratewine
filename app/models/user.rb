class User < ApplicationRecord
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validate :check_password_format, on: :create
  validates :password, length: { minimum: 4 }, on: :create

  has_many :ratings, dependent: :destroy # käyttäjällä on monta ratingia
  has_many :wine_clubs, through: :membership
  has_secure_password

  def check_password_format
    regexps = { " must contain at least one uppercase letter" => /[A-Z]+/, " must contain at least one digit" => /\d+/ }
    regexps.each do |rule, reg|
      errors.add(:password, rule) unless password.match(reg)
    end
  end
end
