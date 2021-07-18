require 'rails_helper'

RSpec.describe 'Application Show Page' do
  describe 'Application details' do

    it 'displays application information' do
      application = create(:application)

      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(application.description)
      expect(page).to have_content("Application status: In Progress")
    end

    it 'user sees a section to search for pet by name' do

      Pet.destroy_all
      Application.destroy_all
      PetApplication.destroy_all

      application = create(:application)
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet = application.pets.create!(name: 'Clyde', breed: "Bengal", age: 5, adoptable: true, shelter: shelter)

      visit "applications/#{application.id}"

      expect(page).to have_content("Add a Pet to this Application")

      fill_in "search", with: pet.name

      click_on 'Submit'

      expect(page).to have_content("Name: #{pet.name}")
      expect(page).to have_content("Breed: #{pet.breed}")
      expect(page).to have_content("Age: #{pet.age}")
      expect(page).to have_content("Adoptable: #{pet.adoptable}")
    end

    it 'user sees a button next to each pet to add pet to the application' do
      application = create(:application)
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet = application.pets.create!(name: 'Clyde', breed: "Bengal", age: 5, adoptable: true, shelter: shelter)

      visit "applications/#{application.id}"

      fill_in "search", with: pet.name
      click_on 'Submit'

      expect(page).to have_button("Adopt: #{pet.name}")
    end

    it 'user can click on adopt button to add a pet to the application' do
      Shelter.destroy_all
      Pet.destroy_all
      Application.destroy_all

      application = create(:application)
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
      pet = application.pets.create!(name: 'Clyde', breed: "Bengal", age: 5, adoptable: true, shelter: shelter)

      visit "/applications/#{application.id}"

      fill_in "search", with: pet.name
      click_on 'Submit'
      click_on "Adopt: #{pet.name}"

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Pets Applied For:")
      expect(page).to have_link("#{pet.name}")
      expect(PetApplication.last.application_id).to eq(application.id)
      expect(PetApplication.last.pet_id).to eq(pet.id)
    end
  end
end
