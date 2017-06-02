require 'rails_helper'

feature  "Category" do

  before :each do
    login(User.create(email: "paromitadgp@gmail.com"))
  end

  scenario "index page" do
    visit categories_path
    expect(page).to have_content('Categories')
    expect(page).to have_css('table.table-last')
  end

  scenario "new category page" do
    visit new_category_path
    find_button('Create')
  end

  scenario "create new category" do
    visit new_category_path
    fill_in "Name", with: "Monitor"
    expect { click_button 'Create' }.to change(Category, :count).by(1)
  end

  scenario "edit category page" do
    category = FactoryGirl.create(:category)
    visit edit_category_path(category)
    find_button('Update')
  end

  scenario "update category" do
    category = FactoryGirl.create(:category)
    visit edit_category_path(category)
    category.reload
    expect(current_path) == categories_path
  end
end
