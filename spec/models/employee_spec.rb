require 'rails_helper'

describe Employee  do
  describe "#name_or_email" do
    let!(:employee)         { create(:employee) }
    let!(:another_employee) { create(:employee, name: nil) }

    context "when name and email is present" do
      it "should return name" do
        expect(employee.name_or_email).to eq("#{employee.name}")
      end
    end

    context "when only email is present" do
      it "should return email" do
        expect(another_employee.name_or_email).to eq("#{another_employee.email}")
      end
    end
  end
end
