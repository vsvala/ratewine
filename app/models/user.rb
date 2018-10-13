class User < ApplicationRecord
  include RatingAverage
  has_many :ratings, dependent: :destroy # käyttäjällä on monta ratingia
  has_many :wines, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :wine_clubs, through: :memberships

  has_secure_password

  validates :username, length: { minimum: 3, maximum: 30 } # uniqueness: true,
  validates :password, length: { minimum: 4 },
                       format: {
                         with: /[A-Z].*\d|\d.*[A-Z]/,
                         message: "must contain one capital letter and number"
                       }

  scope :admin, -> { where admin: true }

  def favorite_wine
    return nil if ratings.empty? # palautetaan nil jos reittauksia ei ole

    ratings.order(score: :desc).limit(1).first.wine
  end

  def favorite_wine_style
    return nil if ratings.empty? # palautetaan nil jos reittauksia ei ole

    ratings.order(score: :desc).limit(1).first.wine.style.name
  end

  def favorite_wineyard
    return nil if ratings.empty? # palautetaan nil jos reittauksia ei ole

    ratings.order(score: :desc).limit(1).first.wine.wineyard.name
  end

  def self.top(num)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |b| -(b.ratings.count || 0) }
    sorted_by_rating_in_desc_order.take(num)
  end
end
