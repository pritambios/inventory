require 'rails_helper'

feature "Item" do

  before :each do
    login(User.create(email: "paromitadgp@gmail.com"))
  end

  scenario "index page" do
    visit items_path
    expect(page).to have_css('table.item-index')
  end

  scenario "filter item's by Select Category" do
    category = FactoryGirl.create(:category, name: "Monitor")
    brand = FactoryGirl.create(:brand, name: "HP")
    another_category = FactoryGirl.create(:category, name: "Keyboard")
    another_brand = FactoryGirl.create(:brand, name: "Del")
    item = FactoryGirl.create(:item, category: category, brand: brand)
    another_item = FactoryGirl.create(:item, category: another_category, brand: another_brand)

    visit items_path
    select 'Monitor', from: 'category'
    expect(page).to have_content(item.name)
    expect(page).not_to have_content(another_item.name)
  end

  scenario "filter item's by Select Brand" do
    category = FactoryGirl.create(:category, name: "Monitor")
    brand = FactoryGirl.create(:brand, name: "HP")
    another_category = FactoryGirl.create(:category, name: "Keyboard")
    another_brand = FactoryGirl.create(:brand, name: "Del")
    item = FactoryGirl.create(:item, category: category, brand: brand)
    another_item = FactoryGirl.create(:item, category: another_category, brand: another_brand)

    visit items_path
    select 'Del', from: 'brand'
    expect(page).to have_content(another_item.name)
    expect(page).not_to have_content(item.name)
  end

  scenario "filter item's by Select Parent" do
    category = FactoryGirl.create(:category, name: "Monitor")
    brand = FactoryGirl.create(:brand, name: "HP")
    another_category = FactoryGirl.create(:category, name: "Keyboard")
    another_brand = FactoryGirl.create(:brand, name: "Del")
    category1 = FactoryGirl.create(:category, name: "Mouse")
    brand1 = FactoryGirl.create(:brand, name: "Lenovo")
    parent_item = FactoryGirl.create(:item, category: category, brand: brand)
    another_item = FactoryGirl.create(:item, category: another_category, brand: another_brand, parent: parent_item)
    item = FactoryGirl.create(:item, category: category1, brand: brand1)

    visit items_path
    select 'HP Monitor', from: 'parent'
    expect(page).to have_content(another_item.name)
    expect(page).not_to have_content(item.name)
  end

  scenario "filter item's by Select Status Allocated" do
    employee = FactoryGirl.create(:employee)
    category = FactoryGirl.create(:category, name: "Monitor")
    brand = FactoryGirl.create(:brand, name: "HP")
    another_category = FactoryGirl.create(:category, name: "Keyboard")
    another_brand = FactoryGirl.create(:brand, name: "Del")
    category1 = FactoryGirl.create(:category, name: "Mouse")
    brand1 = FactoryGirl.create(:brand, name: "Lenovo")
    parent_item = FactoryGirl.create(:item, category: category, brand: brand, discarded_at: nil, employee: nil)
    another_item = FactoryGirl.create(:item, category: another_category, brand: another_brand, parent: parent_item, discarded_at: Date.today, employee: nil)
    item = FactoryGirl.create(:item, category: category1, brand: brand1, employee: employee)

    visit items_path
    select 'Allocated', from: 'status'
    expect(page).to have_content(item.name)
    expect(page).not_to have_content(another_item.name)
    expect(page).not_to have_content(parent_item.name)
  end

  scenario "filter item's by Select Status Unallocated" do
    employee = FactoryGirl.create(:employee)
    category = FactoryGirl.create(:category, name: "Monitor")
    brand = FactoryGirl.create(:brand, name: "HP")
    another_category = FactoryGirl.create(:category, name: "Keyboard")
    another_brand = FactoryGirl.create(:brand, name: "Del")
    category1 = FactoryGirl.create(:category, name: "Mouse")
    brand1 = FactoryGirl.create(:brand, name: "Lenovo")
    parent_item = FactoryGirl.create(:item, category: category, brand: brand, discarded_at: nil)
    another_item = FactoryGirl.create(:item, category: another_category, brand: another_brand, parent: parent_item, discarded_at: Date.today)
    item = FactoryGirl.create(:item, category: category1, brand: brand1, employee: employee)

    visit items_path
    select 'Unallocated', from: 'status'
    expect(page).to have_content(parent_item.name)
    expect(page).to have_content(another_item.name)
    expect(page).not_to have_content(item.name)
  end

  scenario "filter item's by Select Status Discarded" do
    employee = FactoryGirl.create(:employee)
    category = FactoryGirl.create(:category, name: "Monitor")
    brand = FactoryGirl.create(:brand, name: "HP")
    another_category = FactoryGirl.create(:category, name: "Keyboard")
    another_brand = FactoryGirl.create(:brand, name: "Del")
    category1 = FactoryGirl.create(:category, name: "Mouse")
    brand1 = FactoryGirl.create(:brand, name: "Lenovo")
    parent_item = FactoryGirl.create(:item, category: category, brand: brand, discarded_at: nil)
    another_item = FactoryGirl.create(:item, category: another_category, brand: another_brand, parent: parent_item, discarded_at: Date.today)
    item = FactoryGirl.create(:item, category: category1, brand: brand1, employee: employee)

    visit items_path
    select 'Discarded', from: 'status'
    expect(page).to have_content(another_item.name)
    expect(page).not_to have_content(parent_item.name)
    expect(page).not_to have_content(item.name)
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
