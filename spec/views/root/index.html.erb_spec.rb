require 'rails_helper'

RSpec.describe "root/index.html.erb", type: :view do
  it 'contains a `form`' do
    render template: "root/index.html.erb"
    expect(rendered).to match /form/
  end

  it 'contains a `weather` id' do
    render template: "root/index.html.erb"
    expect(rendered).to match /weather/
  end

  it 'display an input for the `address`' do
    render template: "root/index.html.erb"
    expect(rendered).to match /address/
  end

  it 'display a button for the `get-weather`' do
    render template: "root/index.html.erb"
    expect(rendered).to match /get-weather/
  end

  it 'display a button for the `random-city`' do
    render template: "root/index.html.erb"
    expect(rendered).to match /random-city/
  end
end
