require 'faker'

FactoryBot.define do
  factory :brand do |f|
    f.name { Faker::Name.name }
  end
end
