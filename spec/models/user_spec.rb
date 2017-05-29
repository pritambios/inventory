require 'rails_helper'

describe User  do
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
        expect(another_user.name_or_email).to eq("#{another_user.email}")
      end
    end
  end
end
