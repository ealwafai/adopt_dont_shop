require 'rails_helper'

RSpec.describe 'Application Show Page' do
  describe 'Application details' do
    before :each do
      @app = create(:application)
      @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = create(:pet, shelter_id: @shelter.id)
      @pet_2 = create(:pet, shelter_id: @shelter.id)
    end

    it 'displays application information' do
      # app = create(:application)
      # shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      # clyde = app.pets.create!(adoptable: true, age: 5, breed: 'Bengal Cat', name: 'Clyde', shelter: shelter)
      # stomper = app.pets.create!(adoptable: false, age: 2, breed: 'Ragdoll', name: 'Stomper', shelter: shelter)

      visit "/applications/#{@app.id}"

      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.street_address)
      expect(page).to have_content(@app.description)
      expect(page).to have_content(@app.status)
    end

    it 'displays the names of all the pets for this application' do

      visit "/applications/#{@app.id}"

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
    end

    it 'shows pet name as a link to each of their show page' do

     visit "/applications/#{@app.id}"

     click_link "#{@pet_1.name}"

     expect(current_path).to eq("/pets/#{@pet_1.id}")
   end
  end
end
