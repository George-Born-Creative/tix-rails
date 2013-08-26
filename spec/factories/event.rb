FactoryGirl.define do
  factory :event do |event|
    title "Ellis Paul"
    slug "ellis-paul"
    account_id "1"
    body ""
    starts_at { Time.zone.now }
    announce_at { Time.zone.now }
    info "Full dinner and drink menu available <br/> All ages <br/> The Lobby Bar opens at 6:30pm <br/> General admission seating<br/> First come, first seated"
    set_times "<br/> 5:30 - The new Lobby Bar opens<br/>6:30 - Doors<br/>7:30 - Ellis Paul"
    price_freeform "$20 "
    cat "adult"
    buytix_url_old "http://jamminjava.3dcartstores.com/product.asp?itemid=1917"
    disable_event_title true
    association :account
    association :headliner
    association :secondary_headliner
  end
end