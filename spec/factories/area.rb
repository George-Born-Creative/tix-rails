FactoryGirl.define do 
  factory :ga_area do
    max_tickets 100
    label 'GA'
  end
  
  factory :area do
    label "K5"
    stack_order 0
    type "circle"
    cx 134.196
    cy 366.698
    r 4.469
    max_tickets 1
  end
end