class WeathermappingApi
  def self.weather_in(city)
    url = "http://api.apixu.com/v1/current.xml?key=#{key}&q=#{city}"
    # url = "http://api.apixu.com/v1/current.json?key=#{ENV['APIXU_APIKEY']}&q=#{city}"

    response = HTTParty.get(url)
    response.parsed_response['current']
    weathers = response.parsed_response["root"]["current"]

    return [] if weathers.is_a?(Hash) && weathers['last_updated'].nil?

    weathers = [weathers] if weathers.is_a?(Hash)
    weathers.map do |weather|
      Weather.new(weather)
    end
  end

  def self.key
    "6ba400cf4fce47dba82104613180610"
    # raise "APIXU_APIKEY env variable not defined" if ENV['APIXU_APIKEY'].nil?
    # ENV['APIXU_APIKEY']
  end
end
