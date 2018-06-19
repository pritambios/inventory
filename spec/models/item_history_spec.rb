require "rails_helper"

describe ItemHistory do
  context "scopes" do
    let(:category)     { create(:category) }
    let(:item)         { create(:item, category: category) }
    let(:another_item) { create(:item, category: category) }

    describe ".order_descending" do
      it "should order issue names as per date/time created in desc order" do
        expect(ItemHistory.order_descending).to eq([item.item_histories.first, another_item.item_histories.first])
      end
    end
  end
end
