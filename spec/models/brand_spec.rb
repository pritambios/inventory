require 'rails_helper'

describe Brand do
  context "scopes" do
    let(:brand)         { create(:brand, deleted_at: nil, name: "Microsoft") }
    let(:another_brand) { create(:brand, deleted_at: Time.zone.now, name: "Frontech") }

    describe ".active" do
      context "when brand is active" do
        it "should include active brands" do
          expect(Brand.active).to include(brand)
        end
      end

      context "when brand is inactive" do
        it "should not include inactive brands" do
          expect(Brand.active).not_to include(another_brand)
        end
      end
    end

    describe ".order_by_name" do
      it "should order brand names alphabetically" do
        expect(Brand.order_by_name).to eq([another_brand, brand])
      end
    end
  end

  describe "#category_wise_item_count" do
    let!(:category)      { create(:category) }
    let!(:brand)         { create(:brand, deleted_at: nil, name: "Microsoft") }
    let!(:another_brand) { create(:brand, name: "Frontech") }
    let!(:item)          { create(:item, category: category, brand: brand) }

    context "when item present" do
      it "should return category name associated with the item" do
        expect(brand.category_wise_items_count).to eq("#{category.name}-1")
      end
    end

    context "when item not present" do
      it "should return nil" do
        expect(another_brand.category_wise_items_count).to be_empty
      end
    end
  end
end
