require 'rails_helper'

feature  "Issue" do
  before :each do
    login(User.create(email: "paromitadgp@gmail.com"))
  end

  scenario "index page" do
    visit issues_path

    expect(page).to have_css('table.issues-list')
  end

  scenario "new issue page" do
    visit new_issue_path

    find_button('Create')
  end

  scenario "create new issue" do
    category = FactoryGirl.create(:category, name: "Monitor")
    brand = FactoryGirl.create(:brand, name: "HP")
    item = FactoryGirl.create(:item, category: category, brand: brand)
    visit new_issue_path

    fill_in "Title", with: "issue title"
    select 'Hp Monitor', from: 'issue[item_id]'
    expect { click_button 'Create' }.to change(Issue, :count).by(1)
  end

  scenario "edit issue page" do
    issue = FactoryGirl.create(:issue)
    visit edit_issue_path(issue)

    find_button('Update')
  end

  scenario "update issue" do
    category = FactoryGirl.create(:category, name: "Monitor")
    brand = FactoryGirl.create(:brand, name: "HP")
    item = FactoryGirl.create(:item, category: category, brand: brand)
    issue = FactoryGirl.create(:issue, item: item)
    visit edit_issue_path(issue)

    issue.reload
    expect(current_path) == issues_path
  end
end
