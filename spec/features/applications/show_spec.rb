require 'rails_helper'

RSpec.describe 'Application Show Page' do
  describe 'Application details' do
    before :each do
      @app = Application.create!(name: 'Ezzedine Alwafai', street_address: '1010 Main St', city: 'Memphis', state: 'Tennessee', zip_code: '38134', description: 'I love doggies', status: :in_progress)
      @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @clyde = @app.pets.create!(adoptable: true, age: 5, breed: 'Bengal Cat', name: 'Clyde', shelter: @shelter)
      @stomper = @app.pets.create!(adoptable: false, age: 2, breed: 'Ragdoll', name: 'Stomper', shelter: @shelter)
    end

    it 'displays application information' do

      visit "/applications/#{@app.id}"

      expect(page).to have_content(@app.name)
      expect(page).to have_content('1010 Main St, Memphis, Tennessee, 38134')
      expect(page).to have_content(@app.description)
      expect(page).to have_content('Application status: In Progress')
    end

    it 'displays the names of all the pets for this application' do

      visit "/applications/#{@app.id}"

      expect(page).to have_content(@clyde.name)
      expect(page).to have_content(@stomper.name)
    end

    it 'shows pet name as a link to each of their show page' do

     visit "/applications/#{@app.id}"

     click_link 'Clyde'

     expect(current_path).to eq("/pets/#{@clyde.id}")
   end
  end
end
