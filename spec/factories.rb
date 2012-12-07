FactoryGirl.define do
  factory :account do
    subdomain 'jamminjava'
  end
   
  factory :artist do
    name "Ellis Paul"
    body "<p>\r\n\t<span class=\"nfakPe\">Ellis</span> <span class=\"nfakPe\">Paul</span> is one of the leading voices in American songwriting. He was a principle leader in the wave of singer/songwriters that emerged from the Boston folk scene, creating a movement that revitalized the national acoustic circuit with an urban, literate, folk pop style that helped renew interest in the genre in the 1990&#39;s. His charismatic, personally authentic performance style has influenced a generation of artists away from the artifice of pop, and closer towards the realness of folk. Though he remains among the most pop-friendly of today&#39;s singer-songwriters - his songs regularly appear in hit movie and TV soundtracks - he has bridged the gulf between the modern folk sound and the populist traditions of Woody Guthrie and Pete Seeger more successfully than perhaps any of his songwriting peers.</p>\r\n<p>\r\n\tHe is a critically-acclaimed singer, songwriter, poet, and troubadour originally hailing from a potato farming family in northern Maine. He is the recipient of thirteen Boston Music Awards, second only to multi-platinum act, Aerosmith. Over the course of fifteen years, Ellis Paul has built a vast catalog of music which weds striking poetic imagery and philosophical introspection with hook-laden melodies.</p>\r\n"
    url "http://www.ellispaul.com/"
    myspace_url ""
    facebook_url "http://www.facebook.com/#%21/pages/Ellis-Paul/9293768718"
    audio_sample_url "http://click.linksynergy.com/fs-bin/stat?id=*FknwilNy5I&offerid=146261&type=3&subid=0&tmpid=1826&RD_PARM1=http%253A%252F%252Fitunes.apple.com%252Fus%252Fartist%252Fellis%252Fid2533191%253Fuo%253D4%2526partnerId%253D30"
    video_url "http://www.youtube.com/user/ellispaul"
    twitter "http://twitter.com/ellispaulsongs"
    youtube1 "<iframe width=\"300\" height=\"255\" src=\"http://www.youtube.com/embed/sfcTS-wCZHM\" frameborder=\"0\" allowfullscreen></iframe>"
    youtube2 "<iframe width=\"300\" height=\"255\" src=\"http://www.youtube.com/embed/uepurGa9ZBA\" frameborder=\"0\" allowfullscreen></iframe>"
    id_old 314.0
    id_old_image 16186
  end

  factory :event do
    title "Ellis Paul"
    body ""
    starts_at { Time.zone.now }
    announce_at { Time.zone.now }
    info "Full dinner and drink menu available <br/> All ages <br/> The Lobby Bar opens at 6:30pm <br/> General admission seating<br/> First come, first seated"
    set_times "<br/> 5:30 - The new Lobby Bar opens<br/>6:30 - Doors<br/>7:30 - Ellis Paul"
    price_freeform "$20 "
    cat "adult"
    buytix_url_old "http://jamminjava.3dcartstores.com/product.asp?itemid=1917"
    slug "ellis-paul"
    disable_event_title true
  end
  
  factory :chart do 
    name "Ellis Paul chart JAMMIN JAVA SEATED"
    label "Ellis Paul chart JAMMIN JAVA SEATED"
    width 398.417
    height 639.46
    background_color "#000000"
    master false
  end
  
  factory :section do
    label "Premier"
    seatable true
    color "#FFE600"
    index 2
  end
  
  factory :price do
    base { 15.0 + rand(4) }
    service { 3.0 + rand(1) }
    tax 0.0
  end
  
  factory :gateway do
    provider "authorize"
    login "8z9G2RuzM"
    password "573te5kS8c245CSq"
    activated_at { Time.zone.now }
    mode "test"
  end
  
  factory :area do
    label "K5"
    stack_order 0
    type "circle"
    cx 134.196
    cy 366.698
    r 4.469
    max_tickets 1
    
    factory :ga_area do
      max_tickets 100
      label 'GA'
    end
  end
  
  factory :user do
    first_name 'John'
    last_name 'Smith'
    email 'shaun+john@squiid.com'
    password '123456'
  end

end

