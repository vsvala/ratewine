class Rating <ActiveRecord::Base
  belongs_to :wine

  def to_s
   "#{wine.name} #{score}"   
  end
end
