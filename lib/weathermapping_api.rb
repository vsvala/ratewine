class WeathermappingApi
  def self.weather_in(city)
    url = "http://api.apixu.com/v1/current.xml?key=6ba400cf4fce47dba82104613180610&q=#{city}"

    response = HTTParty.get "#{url}"
    weathers = response.parsed_response["root"]["current"]

    return [] if weathers.is_a?(Hash) && weathers['last_updated'].nil?

    weathers = [weathers] if weathers.is_a?(Hash)
    weathers.map do |weather|
      Weather.new(weather)
    end
  end

  def self.key
    "6ba400cf4fce47dba82104613180610"
  end
end
