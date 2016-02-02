include FactoryGirl::Syntax::Methods
include InitialTestData::Utilities

0.upto(2) do |n|
  store create(:customer, email: "test#{n}@example.jp"), "test#{n}"
end
