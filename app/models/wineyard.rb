# frozen_string_literal: true

# My comment
class Wineyard < ActiveRecord::Base
  include RatingAverage
  has_many :wines, dependent: :destroy
  has_many :ratings, through: :wines

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                    less_than_or_equal_to: 2018,
                                    only_integer: true }

end
