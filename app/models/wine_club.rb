class WineClub < ApplicationRecord
    has_many :membership, dependent: :destroy
    has_many  :user,through: :memberships

def to_s
    "#{name}, #{city}"  
    end
end
