require 'rails_helper'

RSpec.describe Weather, type: :model do

  describe 'Public Class Method' do
    describe '.search' do
      let(:address) { '' }
      
      it 'returns nil' do
        weather = Weather.search(address)
        expect(weather).to be_nil
      end
    end
  end
end
