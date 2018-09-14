class Wineyard < ActiveRecord::Base
  has_many :wines, dependent: :destroy
end



