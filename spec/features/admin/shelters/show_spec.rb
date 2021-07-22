require 'rails_helper'

 RSpec.describe 'Shelter Show Page' do
   it 'displays shelter details' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    visit '/admin/shelters'

    expect(page).to have_content(shelter.name)
   end
 end
