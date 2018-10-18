class User < ApplicationRecord
  # attr_accessor :name, :password
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

  # ,if: :login_social? #:if => :login_social?
  # def self.create_with_omniauth(auth)
  #   create! do |user|
  #     user.provider = auth['provider']
  #     user.uid = auth['uid']
  #     # user.oauth_token = auth.credentials.token
  #     # user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     # user.save!
  #     if auth['info']
  #     user.name = auth['info']['name'] || ""
  # end

  # def self.from_omniauth(auth)
  # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  # user.username =auth.uid
  # # user.password = auth.uidl
  # user.password = Devise.friendly_token[0,20]
  # end
  # end

  # def self.create_with_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_initialize.tap 
  #   create! do |user|
  #     user.provider = auth["provider"]
  #     user.uid = auth["uid"]
  #     user.username = auth["info"]["name"]
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     # user.save!
  #   end
  # end

  # def self.find_by_provider_and_uid(provider, uid)
  #   where(provider: provider, uid: uid).first
  # end
  #   def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_initialize.tap 
  #     create! do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     user.save!
  #   end
  # end

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
