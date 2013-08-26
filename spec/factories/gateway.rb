FactoryGirl.define do
  factory :gateway do
    provider "authorize"
    login "aa"
    password "aa"
    activated_at { Time.zone.now }
    mode "test"
  end
end