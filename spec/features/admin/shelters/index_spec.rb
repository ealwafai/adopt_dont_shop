require 'rails_helper'

RSpec.describe 'Admin Shelters Index' do

  it 'lists all shelters, ordered in reverse by name' do

    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    visit '/admin/shelters'
    within('section#reversed') do
      expect(page).to have_content('All Shelters')
      expect(shelter_2.name).to appear_before(shelter_3.name)
      expect(shelter_3.name).to appear_before(shelter_1.name)
    end
  end

  it 'lists shelters with pending applications' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    app_1 = Application.create!(name: 'Caroline Tan', street_address: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: '80204', description: 'I love kitties', status: :pending)
    app_2 = Application.create!(name: 'Ezze Alwfai', street_address: '1234 fake st', city: 'Lafayette', state: 'Colorado', zip_code: '80328', description: 'I dont have kids', status: :in_progress)
    app_3 = Application.create!(name: 'Marla Shulz', street_address: '2020 Corona st', city: 'Denver', state: 'Colorado', zip_code: '80218', description: 'Im crazy about dogs', status: :pending)

    app_1.pets.create!(name: 'Clyde', breed: "Bengal", age: 5, adoptable: true, shelter: shelter_1)
    app_2.pets.create!(name: 'Stella', breed: 'Golden Retriever', age: 2, adoptable: true, shelter: shelter_2)
    app_3.pets.create!(name: 'Beans', breed: 'German Shepherd', age: 9, adoptable: true, shelter: shelter_3)

    visit '/admin/shelters'
    within('section#pending') do
      expect(page).to have_content('Shelters with Pending Applications')
      expect(page).to have_content('Aurora shelter')
      expect(page).to have_content('Fancy pets of Colorado')
      expect(page).to_not have_content('RGV animal shelter')
    end
  end
end
