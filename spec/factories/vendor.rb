require 'faker'
FactoryBot.define do
  factory :vendor do |f|
    f.name    { Faker::Name.name }
    f.address { Faker::Address.address }
  end
end
