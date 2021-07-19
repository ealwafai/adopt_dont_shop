require 'rails_helper'

RSpec.describe 'user creates a new application' do
  it 'user sees a create new application form' do

    visit '/applications/new'

    expect(page).to have_content('New Application')
    expect(page).to have_field('Name')
    expect(page).to have_field('Street address')
    expect(page).to have_field('City')
    expect(page).to have_field('state')
    expect(page).to have_field('Zip code')
    expect(page).to have_field('Description')
  end

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
    expect(page).to have_content('Application was completed successfully!')
  end

  it 'shows an error if given data was invalid' do

    visit '/applications/new'

    click_on 'Submit'

    expect(page).to have_content("The following errors prevented the application from being saved")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Street address can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Zip code can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
end
