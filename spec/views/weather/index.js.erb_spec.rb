require 'rails_helper'

RSpec.describe "weather/index.js.erb", type: :view do
  let(:weather) { { alert: 'success', message: 'Barranquilla, CO: 90 ºF' } }
  
  before do
    assign(:weather, weather)
  end

  it 'contains `#weather`' do
    render template: "weather/index.js.erb"
    expect(rendered).to match(/#weather/)
  end

  it 'contains `.alert`' do
    render template: "weather/index.js.erb"
    expect(rendered).to match(/.alert/)
  end

  it 'contains "alert-" with the weather[:alert]`' do
    render template: "weather/index.js.erb"
    expect(rendered).to match("alert-#{weather[:alert]}")
  end

  it 'contains the weather[:message]`' do
    render template: "weather/index.js.erb"
    expect(rendered).to match(weather[:message])
  end
end
