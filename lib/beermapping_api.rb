class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.week){ get_places_in(city) }
  end

  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) && places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.find_place_with(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/#{id}"

    response = HTTParty.get url
    place = response.parsed_response["bmp_locations"]["location"]

    Place.new(place)
  end

  def self.key
    "f6e388702ed5bb747ee71a778365e8dc"
    # raise "BEERMAPPING_APIKEY env variable not defined" if ENV['BEERMAPPING_APIKEY'].nil? 
    # ENV['BEERMAPPING_APIKEY']
  end
end
