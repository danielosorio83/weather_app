require 'open_weather'
require 'faker'

class Weather
  APPID = Rails.application.secrets.open_weather_app_id

  DEFAULT_OPTIONS = { APPID: APPID, units: 'imperial' }

  class << self
    def search(city, random = nil)
      response =
        if random.blank?
          by_city(city)
        else
          by_random_city
        end
      parse_response(response)
    end

    private

    def by_city(city)
      OpenWeather::Current.city(city, DEFAULT_OPTIONS)
    rescue
      { 'message' => 'Nothing was found! Please try again with a valid city and country.' }
    end

    def by_random_city
      city = Faker::Address.city
      by_city(city)
    end

    def parse_response(response)
      if response['main'].present?
        { alert: 'success', message: "#{formatted_city_name(response)}: #{response['main']['temp']} ºF" }
      else
        { alert: 'danger', message: response['message'] }
      end
    end

    def formatted_city_name(response)
      "#{response['name']}, #{response['sys']['country']}"
    end
  end
end
