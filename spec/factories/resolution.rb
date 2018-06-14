require 'faker'
FactoryBot.define do
  factory :resolution do |f|
    f.name { Faker::Name.name }
  end
end
