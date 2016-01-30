FactoryGirl.define do
  factory :email do
    sequence(:address) { |n| "member#{n}@example.jp" }
  end
end
