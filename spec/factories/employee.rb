require 'faker'

FactoryGirl.define do
  factory :employee do |f|
    f.name  { Faker::Name.name }
    f.email { Faker::Internet.email }
    active "true"
  end
end
