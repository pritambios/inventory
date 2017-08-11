require 'rails_helper'

describe Issue do
  context "scopes" do
    let!(:issue)         { create(:issue, created_at: Date.yesterday, closed_at: Date.today) }
    let!(:another_issue) { create(:issue, created_at: Date.today, closed_at: nil) }

    describe ".order_descending" do
      it "should order issue names as per date/time created in desc order" do
        expect(Issue.order_descending).to eq([another_issue, issue])
      end
    end

    describe ".unclosed" do
      context "when closed_at is nil" do
        it "should return unclosed issue" do
          expect(Issue.unclosed).to include(another_issue)
        end
      end

      context "when closed_at is not nil" do
        it "should not return closed issues" do
          expect(Issue.unclosed).not_to include(issue)
        end
      end
    end
  end

  describe "#item_closed_at_limitation" do
    let!(:another_item)  { create(:item, purchase_on: Date.today) }
    let!(:another_issue) { create(:issue, item: another_item, closed_at: Date.tomorrow) }

    context "when closed_at date is smaller than purchase_on date" do
      it "should  be valid" do
        expect(another_issue).to be_valid
      end
    end
  end
end
