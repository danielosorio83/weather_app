require 'rails_helper'

RSpec.describe Weather, type: :model do

  describe 'Public Class Method' do
    describe '.search' do
      let(:address) { '' }

      it 'calls `by_city` with `address`' do
        expect(Weather).to receive(:by_city).with(address).and_call_original
        Weather.search(address)
      end

      it 'calls `parse_response`' do
        expect(Weather).to receive(:parse_response).with(kind_of(Hash))
        Weather.search('')
      end

      it 'returns a valid hash' do
        weather = Weather.search(address)
        expect(weather).to be_a(Hash)
        expect(weather).to have_key(:alert)
        expect(weather).to have_key(:message)
      end
    end
  end


  describe 'Private Class Method' do
    describe '.by_city(city)' do
      let(:city){ 'Barranquilla' }

      context 'when error raised' do
        it 'returns the custom error message' do
          allow(OpenWeather::Current).to receive(:city).and_raise('Error')
          response = { 'message' => 'Nothing was found! Please try again with a valid city and country.' }
          expect(Weather.send(:by_city, city)).to eq(response)
        end
      end
      
      it 'calls a `OpenWeather::Current.city` with valid arguments' do
        expect(OpenWeather::Current).to receive(:city).with(city, Weather::DEFAULT_OPTIONS)
        Weather.send(:by_city, city)
      end

      context 'when `city is valid' do
        it 'returns a valid hash' do
          weather = Weather.send(:by_city, city)
          expect(weather).to be_a(Hash)
          expect(weather).to have_key('main')
        end
      end

      context 'when `city` is invalid' do
        it 'returns a valid hash' do
          weather = Weather.send(:by_city, '')
          expect(weather).to be_a(Hash)
          expect(weather).to have_key('message')
        end
      end
    end

    describe '.parse_response(response)' do
      context 'when `response` includes `main`' do
        let(:response) { { 'main' => { 'temp' => '70' } } }
        let(:parse_response) { Weather.send(:parse_response, response) }

        it 'returns :alert with `success`' do
          allow(Weather).to receive(:formatted_city_name).with(response)
          expect(parse_response).to have_key(:alert)
          expect(parse_response[:alert]).to eq('success')
        end

        it 'returns :message to include `ºF`' do
          allow(Weather).to receive(:formatted_city_name).with(response)
          expect(parse_response).to have_key(:message)
          expect(parse_response[:message]).to include(response['main']['temp'])
          expect(parse_response[:message]).to include('ºF')
        end

        it 'returns :message to include the temp' do
          allow(Weather).to receive(:formatted_city_name).with(response)
          expect(parse_response).to have_key(:message)
          expect(parse_response[:message]).to include(response['main']['temp'])
        end
      end

      context 'when `response` NOT includes `main`' do
        let(:response) { { 'message' => 'city not found' } }
        let(:parse_response) { Weather.send(:parse_response, response) }

        it 'returns :alert with `danger`' do
          expect(parse_response).to have_key(:alert)
          expect(parse_response[:alert]).to eq('danger')
        end

        it 'returns :message with `city not found`' do
          expect(parse_response).to have_key(:message)
          expect(parse_response[:message]).to eq(response['message'])
        end
      end
    end

    describe '.formatted_city_name(response)' do
      let(:response) { { 'sys' => { 'country' => 'CO' }, 'name' => 'Barranquilla' } }

      it 'returns the expected string' do
        formatted_city_name = "#{response['name']}, #{response['sys']['country']}"
        expect(Weather.send(:formatted_city_name, response)).to eq(formatted_city_name)
      end
    end
  end
end
