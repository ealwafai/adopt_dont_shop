require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do
#   As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @app_1 = Application.create!(name: 'Caroline Tan', street_address: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: '80204', description: 'I love kitties', status: :pending)

    @pet_1 = @app_1.pets.create!(name: 'Clyde', breed: "Bengal", age: 5, adoptable: true, shelter: @shelter)
    @pet_2 = @app_1.pets.create!(name: 'Beans', breed: 'German Shepherd', age: 9, adoptable: true, shelter: @shelter)
    visit "/admin/applications/#{@app_1.id}"
  end

  it 'admin sees an a button to approve an application for a specific pet' do
    expect(page).to have_button("Approve #{@pet_1.name}")
    expect(page).to have_button("Approve #{@pet_2.name}")
  end

  it 'admin clicks button to approve app and is taken back to the show page' do
    click_button("Approve #{@pet_1.name}")

    expect(current_path).to eq("/admin/applications/#{@app_1.id}")
  end


  it 'admin sees an indicator next to the approved pet but sees no button to approve' do
    expect(page).to_not have_button("Approve #{@pet_1.name}")
    expect(page).to have_content("Approved")
  end
end
