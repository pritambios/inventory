require 'rails_helper'

feature  "Vendor" do
  before :each do
    login(User.create(email: "paromitadgp@gmail.com"))
  end

  scenario "index page" do
    visit vendors_path
    expect(page).to have_css('table.table-last')
  end

  scenario "new vendor page" do
    visit new_vendor_path
    find_button('Create')
  end

  scenario "create new vendor" do
    visit new_vendor_path
    fill_in "Name", with: "paromita"
    fill_in "Address", with: "Kolkata"
    expect { click_button 'Create' }.to change(Vendor, :count).by(1)
  end

  scenario "edit vendor page" do
    vendor = FactoryGirl.create(:vendor)
    visit edit_vendor_path(vendor)
    find_button('Update')
  end

  scenario "update vendor" do
    vendor = FactoryGirl.create(:vendor)
    visit edit_vendor_path(vendor)
    vendor.reload
    expect(current_path) == vendors_path
  end
end
