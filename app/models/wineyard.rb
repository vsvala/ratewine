# frozen_string_literal: true

# My comment
class Wineyard < ActiveRecord::Base
  include RatingAverage
  has_many :wines, dependent: :destroy
  has_many :ratings, through: :wines

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040, less_than_or_equal_to: ->(_wineyard) { Date.current.year }, only_integer: true }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def self.top(n)
    sorted_by_rating_in_desc_order = Wineyard.all.sort_by{ |b| -(b.average_rating || 0) }
    s = sorted_by_rating_in_desc_order.reverse
    s.take(n)
    # sorted_by_rating_in_desc_order.last(n)
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.5.1/Array.html
  end
end
