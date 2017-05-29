require 'rails_helper'

describe "Item" do
  subject { page }

  let!(:user)     { create(:user, first_name: "paromita", last_name: "gorai", email: "paromitadgp@gmail.com") }
  let!(:brand)    { create(:brand) }
  let!(:category) { create(:category) }
  let!(:employee) { create(:employee) }
  let!(:item)     { create(:item, category: category, brand: brand, employee: employee, ) }

  before do
    sign_in
  end

  describe "index page" do
    before do
      visit items_path
    end
    it { should have_content('Items') }
    it { should have_content('Add') }
  end

  describe "create new item" do
    before do
      visit new_item_path
    end
    it { should have_content('New') }
  end

  describe "create new item" do
    before do
      visit new_item_path
    end

    let(:submit) { "Create" }

    describe "with invalid input" do
      it "should not create item" do
        expect {  click_button submit }.not_to change(Item, :count)
      end
    end

    describe "with valid input" do
      before do
        fill_in "model_number", with: "001"
        fill_in "serial_number", with: "320"
        fill_in "issue", with: "System failure"
      end
      it "should save the item" do
        expect { click_button submit }.to change(Item, :count).by(1)
        i = Item.find_by_model_number("001")
        current_path.should == item_path(i)
      end
    end
  end

  describe "edit page" do
    before do
      add_item(item, category, brand)
      visit edit_item_path(item)
    end
    it { should have_content ("Edit Item") }
  end

  describe "edit item page" do
    before do
      add_item(item, category, brand)
      visit edit_item_path(item)
    end

   let(:update) { "Update" }

   describe "with invalid inputs" do
     before do
       fill_in "category", with: nil
     end
     it "should not update item" do
       click_button submit
       should have_selector('ul.errors')
     end
   end

   describe "with valid inputs" do
     before do
       fill_in "category", with: "item.category"
     end
     it "should update item" do
       click_button submit
       item.reload
       current_path.should == item_path(item)
      end
    end
  end
end
