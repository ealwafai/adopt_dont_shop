require 'rails_helper'

RSpec.describe 'user creates a new application' do
  it 'user fills in form' do

    visit '/applications/new'

    fill_in 'Name', with: 'Ezzedine Alwafai'
    fill_in 'Street address', with: '1010 Main St'
    fill_in 'City', with: 'Memphis'
    fill_in 'state', with: 'Tennessee'
    fill_in 'Zip code', with: '38134'
    fill_in 'Description', with: 'I love doggies'
    click_on 'Submit'

    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content('Ezzedine Alwafai')
    expect(page).to have_content('1010 Main St, Memphis, Tennessee, 38134')
    expect(page).to have_content('I love doggies')
    expect(page).to have_content('Application status: In Progress')
  end
end
