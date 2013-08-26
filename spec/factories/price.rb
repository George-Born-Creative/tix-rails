FactoryGirl.define do
  factory :price do
    base { 15.0 + rand(4) }
    service { 3.0 + rand(1) }
    tax 0.0
  end
end