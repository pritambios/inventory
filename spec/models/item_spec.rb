require 'rails_helper'

describe Item do
  context "scopes" do
    let!(:category) { create(:category) }
    let!(:brand)    { create(:brand) }
    let!(:employee) { create(:employee, name: "Raman") }

    describe ".active" do
      let!(:another_category) { create(:category, deleted_at: Date.today) }
      let!(:item)             { create(:item, category: category, discarded_at: Date.new(2018,2,3)) }
      let!(:another_item)     { create(:item, category: another_category) }
      let!(:third_item)       { create(:item, category: category) }
      let!(:fourth_item)      { create(:item, category: another_category, discarded_at: Date.new(2019,2,3)) }

      context "when category is valid and item has not been discarded" do
        it "should return the active item" do
          expect(Item.active).to include(third_item)
        end
      end

      context "when category is valid but item has been discarded" do
        it "should not return the inactive item" do
          expect(Item.active).not_to include(item)
        end
      end

      context "when category is invalid/deleted and item has not been discarded" do
        it "should not return the inactive item" do
          expect(Item.active).not_to include(another_item)
        end
      end

      context "when category is invalid/deleted and item has been discarded" do
        it "should not return the inactive item" do
          expect(Item.active).not_to include(fourth_item)
        end
      end
    end

    describe ".available" do
      let!(:item)                  { create(:item, category: category, brand: brand, created_at: Date.today) }
      let!(:another_item)          { create(:item, category: category, brand: brand, created_at: Date.yesterday) }
      let!(:another_item_checkout) { create(:checkout, item: another_item, checkout: Date.today, check_in: Date.tomorrow) }
      let!(:item_checkout)         { create(:checkout, item: item, checkout: Date.tomorrow, check_in: nil)}

      context "when item is checked out but check_in is nil" do
        it " should return available item" do
          expect(Item.available).to include(another_item)
        end
      end

      context "when item is checked out but check_in is not nil" do
        it "should not return unavailable item" do
          expect(Item.available).not_to include(item)
        end
      end
    end

    describe ".not_erased" do
      let!(:item)         { create(:item, category: category, brand: brand, deleted_at: nil) }
      let!(:another_item) { create(:item, category: category, brand: brand, deleted_at: Date.tomorrow) }

      context "when deleted_at is nil" do
        it "should return items which have not been erased" do
          expect(Item.not_erased).to include(item)
        end
      end

      context "when deleted_at is not nil" do
        it "should not return items which have been erased" do
          expect(Item.not_erased).not_to include(another_item)
        end
      end
    end

    describe ".order_descending" do
      let!(:item)         { create(:item, category: category, brand: brand, created_at: Date.today) }
      let!(:another_item) { create(:item, category: category, brand: brand, created_at: Date.yesterday) }
      let!(:third_item)   { create(:item, category: category, brand: brand, created_at: Date.tomorrow) }
      let!(:fourth_item)  { create(:item, category: category, brand: brand, created_at: Date.new(2018,2,3)) }

      it "should order item names as per date/time with respect to created_at in desc order" do
        expect(Item.order_descending).to eq([fourth_item, third_item, item, another_item])
      end
    end

    describe ".unattached" do
      let!(:item)         { create(:item, category: category, brand: brand, employee: employee) }
      let!(:another_item) { create(:item, category: category, brand: brand, parent: item, employee: employee) }
      let!(:third_item)   { create(:item, category: category, brand: brand) }
      let!(:fourth_item)  { create(:item, category: category, brand: brand) }

      context "parent_id and employee_id is nil" do
        it "should return those items which are unattached" do
          expect(Item.unattached).to include(third_item, fourth_item)
        end
      end
      context "parent_id or employee is not nil" do
        it "should not return those items which are attached" do
          expect(Item.unattached).not_to include(:item, another_item)
        end
      end
    end

    describe ".unavailable" do
      let!(:item)                  { create(:item, category: category, brand: brand, created_at: Date.today) }
      let!(:another_item)          { create(:item, category: category, brand: brand, created_at: Date.yesterday) }
      let!(:another_item_checkout) { create(:checkout, item: another_item, checkout: Date.today, check_in: Date.tomorrow) }
      let!(:item_checkout)         { create(:checkout, item: item, checkout: Date.tomorrow, check_in: nil) }

      context "when item is checked out but check_in is nil" do
        it "should return unavailable item" do
          expect(Item.unavailable).to include(item)
        end
      end

      context "when item is checked out but check_in is not nil" do
        it "should not return unavailable item" do
          expect(Item.unavailable).not_to include(another_item)
        end
      end
    end

    describe ".unallocated_items" do
      let!(:item)         { create(:item, category: category, brand: brand, employee: employee) }
      let!(:another_item) { create(:item, category: category, brand: brand) }

      context "when employee_id is nil" do
        it "should return unallocated items" do
          expect(Item.unallocated_items).to include(another_item)
        end
      end

      context "when employee_id is not nil" do
        it "should not return allocated items" do
          expect(Item.unallocated_items).not_to include(item)
        end
      end
    end

    describe ".allocated_items" do
      let!(:item)         { create(:item, category: category, brand: brand, employee: employee) }
      let!(:another_item) { create(:item, category: category, brand: brand) }

      context "when employee_id is not nil" do
        it "should return those items which are allocated" do
          expect(Item.allocated_items).to include(item)
        end
      end

      context "when employee_id is nil" do
        it "should not return those items which are unallocated" do
          expect(Item.allocated_items).not_to include(another_item)
        end
      end
    end

    describe ".discarded_items" do
      let!(:item)         { create(:item, category: category, brand: brand, created_at: Date.today) }
      let!(:another_item) { create(:item, category: category, brand: brand, created_at: Date.yesterday, discarded_at: Date.tomorrow)}

      context "when discarded_at is not nil" do
        it "should return those items which have been discarded" do
          expect(Item.discarded_items).to include(another_item)
        end
      end

      context "when discarded_it is not nil" do
        it "should not return those items which have not been discarded" do
          expect(Item.discarded_items).not_to include(item)
        end
      end
    end

    describe ".parent_list" do
      let!(:item)         { create(:item, category: category, brand: brand, created_at: Date.today) }
      let!(:another_item) { create(:item, category: category, brand: brand, created_at: Date.today, parent: item) }
      let!(:third_item)   { create(:item, category: category, brand: brand, created_at: Date.today, parent: another_item) }
      let!(:fourth_item)  { create(:item, category: category, brand: brand, created_at: Date.today) }

      context "when parent id is valid" do
        it "should return list of distinct parents" do
          expect(Item.parent_list).to include(item, another_item)
        end
      end

      context "when parent id is invalid" do
        it "should not return list of distinct childs" do
          expect(Item.parent_list).not_to include(third_item, fourth_item)
        end
      end
    end

    describe ".filter_by_category" do
      let!(:another_category) { create(:category) }
      let!(:item)             { create(:item, category: category, brand: brand, created_at: Date.today) }
      let!(:another_item)     { create(:item, category: another_category, brand: brand, created_at: Date.today) }

      context "when category id is valid" do
        it "should return items belonging to that particular category" do
          expect(Item.filter_by_category(category)).to include(item)
        end
      end

      context "when category id is invalid" do
        it "should not return items belonging any other category" do
          expect(Item.filter_by_category(category)).not_to include(another_item)
        end
      end
    end

    describe ".filter_by_brand" do
      let!(:another_brand) { create(:brand) }
      let!(:item)          { create(:item, category: category, brand: brand, created_at: Date.today) }
      let!(:another_item)  { create(:item, category: category, brand: another_brand, created_at: Date.today) }

      context "when brand id is valid" do
        it "should return items belonging to that particular brand" do
          expect(Item.filter_by_brand(brand)).to include(item)
        end
      end

      context "when brand id is invalid" do
        it "should not return items belonging any other brand" do
          expect(Item.filter_by_brand(brand)).not_to include(another_item)
        end
      end
    end

    describe ".filter_by_parent" do
      let!(:item)         { create(:item, category: category, brand: brand, created_at: Date.today) }
      let!(:another_item) { create(:item, category: category, brand: brand, created_at: Date.today) }
      let!(:third_item)   { create(:item, category: category, brand: brand, created_at: Date.today, parent: item) }
      let!(:fourth_item)  { create(:item, category: category, brand: brand, created_at: Date.today, parent: another_item) }

      context "when parent id is valid" do
        it "should return items belonging to that particular parent" do
          expect(Item.filter_by_parent(item)).to include(third_item)
        end
      end

      context "when parent id is invalid" do
        it "should not return items belonging to other parents" do
          expect(Item.filter_by_parent(item)).not_to include(fourth_item)
        end
      end
    end
  end

  describe "#edit_item_details" do
    let!(:category)         { create(:category) }
    let!(:brand)            { create(:brand) }
    let!(:another_category) { create(:category) }
    let!(:another_brand)    { create(:brand) }
    let!(:item)             { create(:item, category: category, brand: brand, created_at: 6.day.ago.to_datetime) }

    context "when category is changed" do
      before do
        item.update(category: another_category)
      end

      it "should be invalid" do
        expect(item).to be_invalid
      end
    end

    context "when brand is changed" do
      before do
        item.update(brand: another_brand)
      end

      it "should be invalid" do
        expect(item).to be_invalid
      end
    end
  end

  describe ".unassociated_items" do
    let!(:item)               { create(:item) }
    let!(:child_item)         { create(:item, parent: item) }
    let!(:unassociated_item1) { create(:item) }
    let!(:unassociated_item2) { create(:item) }

    context "when parent is present" do
      it "should return items which have no parent" do
        expect(Item.unassociated_items(item)).to include(unassociated_item1, unassociated_item2)
      end
    end
  end

  describe ".filter_by_status" do
    let!(:employee)         { create(:employee) }
    let!(:allocated_item)   { create(:item, employee: employee) }
    let!(:discarded_item)   { create(:item, discarded_at: Date.today) }
    let!(:unallocated_item) { create(:item) }

    context "when employee_id is nil" do
      it "should return unallocated items" do
        expect(Item.filter_by_status("Unallocated")).to eq([discarded_item, unallocated_item])
      end
    end

    context "when discarded_at is not nil" do
      it "should return discarded items" do
        expect(Item.filter_by_status("Discarded")).to eq([discarded_item])
      end
    end

    context "when employee_id is present" do
      it "should return allocated items" do
        expect(Item.filter_by_status("Allocated")).to eq([allocated_item])
      end
    end
  end

  describe "#change_parent" do
    let!(:item)         { create(:item) }
    let!(:second_item)  { create(:item) }
    let!(:another_item) { create(:item, parent: second_item) }

    context "when parent can be changed" do
      before do
        another_item.change_parent(item)
      end

      it "should change the parent" do
        expect(another_item.parent_id).to eq(item.id)
      end
    end

    context "when parent cannot be changed" do
      before do
        second_item.change_parent(another_item)
      end

      it "should change the parent" do
        expect(second_item.parent_id).not_to eq(another_item.id)
      end
    end

  end

  describe "#add_child" do
    let!(:item)         { create(:item) }
    let!(:another_item) { create(:item, parent: item) }
    let!(:child_item)   { create(:item) }

    context "when child can be added" do
      before do
        item.add_child(child_item)
      end

      it "should add as child" do
        expect(child_item.parent_id).to eq(item.id)
      end
    end

    context "when child cannot be added" do
      before do
        another_item.add_child(item)
      end

      it "should not add as child" do
        expect(item.parent_id).not_to eq(another_item.id)
      end
    end
  end

  describe "#name" do
    let!(:brand)        { create(:brand, name: "HP") }
    let!(:category)     { create(:category, name: "Monitor") }
    let!(:item)         { create(:item, brand: brand, category: category) }
    let!(:another_item) { create(:item, brand: nil, category: category) }

    context "when brand is present" do
      it "should give the name of brand and category for item" do
        expect(item.name).to eq("HP Monitor")
      end
    end

    context "when brand is not present" do
      it "should give only category for item" do
        expect(another_item.name).to eq(" Monitor")
      end
    end
  end

  describe "#name_with_id" do
    let!(:brand)    { create(:brand, name: "HP") }
    let!(:category) { create(:category, name: "Monitor") }
    let!(:item)     { create(:item, brand: brand, category: category) }

    context "when item is present" do
      it "should give the item name with ID" do
        expect(item.name_with_id).to eq("HP Monitor ##{item.id}")
      end
    end
  end

  describe "#pending_checkout" do
    let!(:item)             { create(:item) }
    let!(:employee)         { create(:employee) }
    let!(:another_employee) { create(:employee) }
    let!(:item_checkout)    { create(:checkout, employee: employee, check_in: nil, reason: "System failure", checkout: Date.today, item: item, created_at: Date.today) }
    let!(:another_item_checkout) { create(:checkout, employee: another_employee, check_in: nil, reason: "any reason", checkout: Date.today, item: item, created_at: Date.today-1) }

    context "when check_in is nil" do
      it "should return all checkouts whose check_in is nil" do
        expect(item.pending_checkout).to eq(item_checkout)
      end
    end
  end

  describe "#reallocate" do
    let!(:employee)         { create(:employee) }
    let!(:item)             { create(:item, employee: employee) }
    let!(:another_employee) { create(:employee) }

    context "when item is reallocated to an employee" do
      it "should return true" do
        expect(item.reallocate(employee)).to be true
      end
    end
  end

  describe "#unavailable?" do
    let!(:item)                  { create(:item) }
    let!(:another_item)          { create(:item) }
    let!(:item_checkout)         { create(:checkout, item: item, check_in: Date.today, reason: "anything", checkout: Date.today) }
    let!(:another_item_checkout) { create(:checkout, item: another_item, check_in: nil, reason: "anything", checkout: Date.today) }

    context "when checkin is present" do
      it "should return false" do
        expect(item.unavailable?).to be false
      end
    end

    context "when checkin is not present" do
      it "should return true" do
        expect(another_item.unavailable?).to be true
      end
    end
  end

  describe "#discard" do
    let!(:item) { create(:item) }

    context "when item is discarded" do
      it "should return true" do
        expect(item.discard("system failure")).to be true
      end
    end
  end

  describe "#update_item_history" do
    let!(:employee)         { create(:employee) }
    let!(:another_employee) { create(:employee) }
    let!(:item)             { create(:item, employee: employee, parent: another_item) }
    let!(:another_item)     { create(:item) }
    let!(:parent_item)      { create(:item) }

    context "when employee ID is changed" do
      before do
        item.update(employee: another_employee)
      end

      it "should update_item_history" do
        expect(item.item_histories.size).to eq(2)
      end
    end

    context "when working status is changed" do
      before do
        item.update(working: false)
      end

      it "should update item_history" do
        expect(item.item_histories.size).to eq(2)
      end
    end

    context "when parent is changed" do
      before do
        another_item.update(parent: parent_item)
      end

      it "should update item_history" do
        expect(another_item.item_histories.size).to eq(2)
      end
    end
  end
end
