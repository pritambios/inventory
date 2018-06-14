require 'faker'

FactoryBot.define do
  factory :category do |f|
    f.name { Faker::Name.name }
  end
end
