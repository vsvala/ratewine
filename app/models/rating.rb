# frozen_string_literal: true

# My comment
class Rating < ActiveRecord::Base
  belongs_to :wine
  belongs_to :user   # rating kuuluu myös käyttäjään
  
  def to_s
    "#{wine.name}, #{score}"
  end
end
