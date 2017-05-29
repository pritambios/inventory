require 'rails_helper'

describe "Issue" do
  subject { page }

  let(:user)     { create(:user) }
  let(:employee) { create(:employee) }
  let(:item)     { create(:item) }
  let(:issue)    { create(:issue, item, employee) }

  before do
    login_path(user)
  end

  describe "index page" do
    before do
      visit issues_path(issue)
    end
    it { should have_content('Issues') }
    it { should have_content('New') }
  end

  describe "new" do
    before do
      visit new_issue_path(issue)
    end
    it {  should have_content('Create Issues') }
  end

  describe "create" do
    before do
      visit new_item_path(item)
    end

  describe "with invalid inputs" do
    it "should not create issue" do
      expect {  click_button "Create" }.not_to change(Issue, :count)
    end
  end

  describe "with valid inputs" do
    before do
      fill_in "title", with: "some issue"
      fill_in "item", with: "item"
      fill_in "employee", with: "employee"
      fill_in "description", with: "some description"
    end

    it "should save the issue" do
      expect { click_button "Create" }.to change(Issue, :count).by(1)
    end
  end

    it "should save the issue with given inputs" do
      click_button "Create"
      expect(page).to have_content("some issue")
    end
  end


  describe "edit" do
    before do
      visit edit_issue_path(issue)
    end

   describe "with valid inputs" do
     before do
       fill_in "title", with: "some issue"
     end

     it "should update the issue" do
       click_button "Update"
       expect(page).to have_content("some issue")
     end
   end
 end
end
