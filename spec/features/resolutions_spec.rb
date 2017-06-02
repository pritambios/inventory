require 'rails_helper'

feature  "Resolution" do
  before :each do
    login(User.create(email: "paromitadgp@gmail.com"))
  end

  scenario "index page" do
    visit resolutions_path
    expect(page).to have_content('Resolutions')
    expect(page).to have_css('table.table-last')
  end

  scenario "new resolution page" do
    visit new_resolution_path
    find_button('Add')
  end

  scenario "create new resolution" do
    visit new_resolution_path
    fill_in "Name", with: "Valid"
    expect { click_button 'Add' }.to change(Resolution, :count).by(1)
  end

  scenario "edit resolution page" do
    resolution = FactoryGirl.create(:resolution)
    visit edit_resolution_path(resolution)
    find_button('Update')
  end

  scenario "update resolution" do
    resolution = FactoryGirl.create(:resolution)
    visit edit_resolution_path(resolution)
    resolution.reload
    expect(current_path) == resolutions_path
  end
end
