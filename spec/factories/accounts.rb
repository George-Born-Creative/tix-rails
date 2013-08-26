FactoryGirl.define do
  factory :account do |a|
    a.subdomain Faker::Lorem.word
  end
  
  factory :account_no_subdomain do |a|
    a.subdomain nil
  end
  
  factory :account_two do |a|
    a.subdomain Faker::Lorem.word
  end
  
end