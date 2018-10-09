# frozen_string_literal: true

# My comment
class Rating < ActiveRecord::Base
  include RatingAverage
  belongs_to :wine
  belongs_to :user # rating kuuluu myös käyttäjään
  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }
  def to_s
    "#{wine.name}, #{score}"
  end

  scope :recent, -> { order('created_at DESC').limit(5) }
  scope :active, -> { where "score>0" }
end
