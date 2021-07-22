require 'rails_helper'

RSpec.describe 'Admin Applications Index' do
  it 'lists all applications' do

    app_1 = Application.create!(name: 'Caroline Tan', street_address: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: '80204', description: 'I love kitties', status: :pending)
    app_2 = Application.create!(name: 'Ezzedine Alwafai', street_address: '1234 Main st', city: 'Denver', state: 'Colorado', zip_code: '80021', description: 'I love doggies', status: :pending)

    visit '/admin/applications'

    expect(page).to have_content(app_1.name)
    expect(page).to have_content(app_2.name)
  end
end
