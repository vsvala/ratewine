class Style < ApplicationRecord
  include RatingAverage
  has_many :wines

  def self.top(num)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.average_rating || 0) }
    # sorted_by_rating_in_desc_order.last(n)
    s = sorted_by_rating_in_desc_order.reverse
    s.take(num)
  end
end
