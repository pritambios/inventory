require "rails_helper"

describe Vendor do
  context "scopes" do
    let(:vendor)         { create(:vendor, name: "Mumbai Vendor", address: "Mumbai") }
    let(:another_vendor) { create(:vendor, name: "Ferozpur Vendor", address: "Ferozpur") }

    describe ".order_by_name" do
      it "should order vendor names alphabetically" do
        expect(Vendor.order_by_name).to eq([another_vendor, vendor])
      end
    end
  end
end
