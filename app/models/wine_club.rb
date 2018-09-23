class WineClub < ApplicationRecord
    belongs_to :membership
    belongs_to :user

def to_s
    "#{name}, #{city}"  
    end
end
