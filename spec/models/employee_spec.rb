require 'rails_helper'

describe Employee  do
  context "scopes" do
    let!(:employee)         { create(:employee, name: "Raman") }
    let!(:another_employee) { create(:employee, name: "Naman") }

    describe ".order_by_name" do
      it "should order employees alphabetically according to name" do
        expect(Employee.order_by_name).to eq([another_employee, employee])
      end
    end
  end

  describe "#name_or_email" do
    let!(:employee)         { create(:employee) }
    let!(:another_employee) { create(:employee, name: nil) }

    context "when both name and email are present" do
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

  describe "#deallocate_items" do
    let!(:employee) { create(:employee, active: true) }
    let!(:item)     { create(:item, employee: employee) }

    before do
      employee.update(active: false)
    end

    it "should deallocate items" do
      expect(employee.items.count).to eq(0)
    end
  end
end
