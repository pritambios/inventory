require "rails_helper"

describe Category do
  context "scopes" do
    let!(:category)         { create(:category, deleted_at: nil, name: "Mouse") }
    let!(:another_category) { create(:category, deleted_at: Time.zone.now, name: "Keyboard") }

    describe ".active" do
      context "when category is active" do
        it "should return active categories" do
          expect(Category.active).to include(category)
        end
      end

      context "when category is inactive" do
        it "should not return inactive categories" do
          expect(Category.active).not_to include(another_category)
        end
      end
    end

    describe ".order_by_name" do
      it "should order category names alphabetically" do
        expect(Category.order_by_name).to eq([another_category, category])
      end
    end
  end
end
