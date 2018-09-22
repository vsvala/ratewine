# frozen_string_literal: true

# My comment
class Wine < ActiveRecord::Base
  include RatingAverage
  belongs_to :wineyard
  has_many :ratings, dependent: :destroy
  
  validates :name, presence: true

  def to_s
    "#{name}, #{wineyard.name}"
    # "Wine has #{ratings.count} #{pluralize_help}, average #{average_rating}"
  end
end
