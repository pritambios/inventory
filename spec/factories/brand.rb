require 'faker'

FactoryGirl.define do
  factory :brand do |f|
    f.name { Faker::Name.name }
  end
end
