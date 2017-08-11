require 'rails_helper'

describe Checkout do
  context "scopes" do
    let!(:employee)         { create(:employee) }
    let!(:item)             { create(:item, employee: employee) }
    let!(:checkout)         { create(:checkout, item: item, created_at: Date.yesterday) }
    let!(:another_checkout) { create(:checkout, item: item, check_in: nil, created_at: Date.tomorrow) }

    describe ".order_descending" do
      it "should list Checkouts in descending order" do
        expect(Checkout.order_descending).to eq([another_checkout, checkout])
      end
    end

    describe ".pending" do
      context "when check_in is nil" do
        it "should display pending checkouts" do
          expect(Checkout.pending).to include(another_checkout)
        end

        context "when check_in not nil" do
          it "should not display pending checkouts" do
            expect(Checkout.pending).not_to include(checkout)
          end
        end
      end
    end
  end

  describe "#checkin?" do
    let!(:employee)         { create(:employee) }
    let!(:item)             { create(:item, employee: employee) }
    let!(:checkout)         { create(:checkout, item: item) }
    let!(:another_checkout) { create(:checkout, item: item, check_in: nil) }

    context "when check_in is present" do
      it "should return true" do
        expect(checkout.checkin?).to be true
      end
    end

    context "when check_in not present" do
      it "should return false" do
        expect(another_checkout.checkin?).to be false
      end
    end
  end

  describe "#checkout_limitation" do
    context "when checkout date is before purchase date" do
      let!(:item)     { create(:item, purchase_on: (Date.today)) }
      let!(:checkout) { build(:checkout, item: item, checkout: (Date.today-1)) }

      it "should be invalid" do
        expect(checkout).to be_invalid
      end
    end

    context "when checkout date is after purchase date" do
      let!(:another_item)     { create(:item, purchase_on: (Date.today-1)) }
      let!(:another_checkout) { create(:checkout, item: another_item, checkout: (Date.today)) }

      it "should be valid" do
        expect(another_checkout).to be_valid
      end
    end
  end
end
