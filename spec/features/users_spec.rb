require 'rails_helper'

feature  "User" do
  before :each do
    login(User.create(email: "paromitadgp@gmail.com"))
  end

  scenario "index page" do
    visit users_path
    expect(page).to have_content('Users')
    expect(page).to have_css('table.table-last')
  end

  scenario "new user page" do
    visit new_user_path
    find_button('Add')
  end

  scenario "create new user" do
    visit new_user_path
    fill_in "Email", with: "pgorai@kreeti.com"
    expect { click_button 'Add' }.to change(User, :count).by(1)
  end

  scenario "edit user page" do
    user = FactoryGirl.create(:user)
    visit edit_user_path(user)
    find_button('Update')
  end

  scenario "update user" do
    user = FactoryGirl.create(:user)
    visit edit_user_path(user)
    user.reload
    expect(current_path) == users_path
  end
end
