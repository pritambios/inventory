require 'faker'

FactoryGirl.define do
  factory :checkout do |f|
    item
    f.checkout { Time.zone.today }
    f.reason   { "System failure" }
    f.check_in { Time.zone.today }
    employee
  end
end
