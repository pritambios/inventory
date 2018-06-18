require 'rails_helper'

describe User do
  context "scopes" do
    let!(:user)         { create(:user, first_name: "Sandeep") }
    let!(:another_user) { create(:user, first_name: "Aman") }

    describe ".order_by_name" do
      it "should order User's names alphabetically according to first name" do
        expect(User.order_by_name).to eq([another_user, user])
      end
    end
  end

  describe "#full_name" do
    let!(:user) { create(:user, first_name: "Aman", last_name: "Arora") }

    context "when showing full name" do
      it "combine first_name and last_name" do
        expect(user.full_name).to eq("Aman Arora")
      end
    end
  end

  describe "#name_or_email" do
    let!(:user)         { create(:user) }
    let!(:another_user) { create(:user, first_name: nil, last_name: nil) }

    context "when name and email is present" do
      it "should return name" do
        expect(user.name_or_email).to eq("#{user.first_name} #{user.last_name}")
      end
    end

    context "when only email is present" do
      it "should return email" do
        expect(another_user.name_or_email).to eq(another_user.email.to_s)
      end
    end
  end
end
