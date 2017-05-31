require 'rails_helper'

feature  "Brand" do
  before :each do
    login(User.create(email: "paromitadgp@gmail.com"))
  end

  scenario "index page" do
    visit brands_path

    expect(page).to have_css('table.table-last')
  end

  scenario "new brand page" do
    visit new_brand_path

    find_button('Create')
  end

  scenario "create new brand" do
    visit new_brand_path

    fill_in "Name", with: "HP"
    expect { click_button 'Create' }.to change(Brand, :count).by(1)
  end

  scenario "edit brand page" do
    brand = FactoryGirl.create(:brand)
    visit edit_brand_path(brand)

    find_button('Update')
  end

  scenario "update brand" do
    brand = FactoryGirl.create(:brand)
    visit edit_brand_path(brand)

    brand.reload
    expect(current_path) == brands_path
  end
end
