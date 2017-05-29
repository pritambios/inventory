require 'faker'

FactoryGirl.define do
  factory :category do |f|
    f.name { Faker::Name.name }
  end
end
