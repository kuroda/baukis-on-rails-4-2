include FactoryGirl::Syntax::Methods
include InitialTestData::Utilities

0.upto(1) do |n|
  store create(:administrator, email: "test#{n}@example.co.jp"), "test#{n}"
end
