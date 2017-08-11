require 'faker'

FactoryGirl.define do
  factory :checkout do |f|
    item
    f.checkout { Date.today }
    f.reason   { "System failure" }
    f.check_in { Date.today }
    employee
  end
end
