class Weather < OpenStruct
  def self.rendered_fields
    [:temp_c, :condition, :wind_mph, :wind_dir]
  end
end
