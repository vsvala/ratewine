# frozen_string_literal: true

# My comment
class Wine < ActiveRecord::Base
  include RatingAverage
  # extend Top
  belongs_to :wineyard, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{name}, #{wineyard.name}"
    # "Wine has #{ratings.count} #{pluralize_help}, average #{average_rating}"
  end

  def self.top(num)
    sorted_by_rating_in_desc_order = Wine.all.sort_by{ |b| -(b.average_rating || 0) }
    # sorted_by_rating_in_desc_order.last(n)
    s = sorted_by_rating_in_desc_order.reverse
    s.take(num)
  end

  def self.top_style(num)
    sorted_by_rating_in_desc_order = Wine.all.sort_by{ |b| -(b.average_rating || 0) }
    # sorted_by_rating_in_desc_order.last(n)
    s = sorted_by_rating_in_desc_order.reverse
    s.take(num)
  end
end
