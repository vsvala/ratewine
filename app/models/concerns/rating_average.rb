# frozen_string_literal: true

# My comment
module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    # sum=0
    # ratings.each{ |a| sum+=a.score }
    # sum/ratings.count
    # ratings.sum(:score)/ratings.count
    # return 0 if ratings.empty?
    # ratings.map { |r| r.score }.sum / ratings.count.to_f
    # ratings.average(:score)
    "#{ratings.average(:score)}"
    #"Has #{ratings.count} #{pluralize_help}, average #{ratings.average(:score)}"
  end

  def pluralize_help
    return if ratings.count.zero?

    ratings.count == 1 ? 'rating' : 'rating'.pluralize
  end
end
