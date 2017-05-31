require 'rails_helper'

feature "Item" do

  before :each do
    login(User.create(email: "paromitadgp@gmail.com"))
  end

  scenario "index page" do
    visit items_path

    expect(page).to have_css('table.item-index')
  end

  scenario "new item page" do
    visit new_item_path

    find_button('Create')
  end

  scenario "create new item" do
    category = FactoryGirl.create(:category, name: "Monitor")
    visit new_item_path

    select 'Monitor', from: 'item[category_id]'
    expect { click_button 'Create' }.to change(Item, :count).by(1)
  end

  scenario "edit item page" do
    item = FactoryGirl.create(:item)
    visit edit_item_path(item)

    find_button('Update')
  end

  scenario "update item" do
    item = FactoryGirl.create(:item)

    visit edit_item_path(item)

    item.reload
    expect(current_path) == items_path
  end
end
