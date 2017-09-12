require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'GET #index' do
    context 'when format is `html`' do
      it 'redirects to root_url' do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when format is `js`' do
      it 'returns http success' do
        get :index, xhr: true
        expect(response).to have_http_status(:success)
      end
    end
  end
end
