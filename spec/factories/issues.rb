require 'faker'

FactoryGirl.define do
  factory :issue do
    title "system failure"
    item
    employee
  end
end
