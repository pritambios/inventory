require "rails_helper"

describe Resolution do
  context "scopes" do
    let!(:resolution)         { create(:resolution, name: "Unresolved") }
    let!(:another_resolution) { create(:resolution, name: "Resolved") }

    describe ".order_by_name" do
      it "should order resolutions alphabetically according to name" do
        expect(Resolution.order_by_name).to eq([another_resolution, resolution])
      end
    end
  end
end
