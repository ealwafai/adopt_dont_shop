require 'rails_helper'

RSpec.describe 'the veterinarian update' do
  it "shows the veterinarian edit form" do
    shelter = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    pet = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter.id)

    visit "/pets/#{pet.id}/edit"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Breed')
    expect(find('form')).to have_content('Adoptable')
    expect(find('form')).to have_content('Age')
  end

  

  context "given invalid data" do
    it 're-renders the edit form' do
      shelter = Shelter.create(name: 'Heavenly pets', city: 'Aurora, CO', foster_program: false, rank: 7)
      pet = Pet.create(adoptable: false, age: 3, breed: 'Whippet', name: 'Annabelle', shelter_id: shelter.id)

      visit "/pets/#{pet.id}/edit"

      fill_in 'Name', with: ''
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/pets/#{pet.id}/edit")
    end
  end
end
