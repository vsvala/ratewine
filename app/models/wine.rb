# frozen_string_literal: true

# My comment
class Wine < ActiveRecord::Base
  include RatingAverage
  belongs_to :wineyard
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{name}, #{wineyard.name}"
    # "Wine has #{ratings.count} #{pluralize_help}, average #{average_rating}"
  end
end
