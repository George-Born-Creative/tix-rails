# -*- encoding : utf-8 -*-
require 'json'
require './lib/svg_parser'
require 'date'

Event.delete_all
Ticket.delete_all
Area.delete_all
Chart.delete_all


#### 
#### Event
####

eve = Event.new
eve.starts_at = DateTime.now + 10 #days
eve.ends_at = DateTime.now + 12 #days
eve.title = "Jammin Java’s Mid-Atlantic Band Battle 7"
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/JamminJavaMid-AtlanticBandBattle7.jpg'
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/JamminJavaMid-AtlanticBandBattle7_thumb.jpg'
eve.body =   <<-eos
<p>Jammin Java presents The SEVENTH Mid-Atlantic Band Battle. Everyone   had such a killer time on all 6 battles that we're doing it all over   again! We are searching for the best bands of any genre from up-and-down   the East Coast to prove that they have what it takes to win $2500 CASH   and more!&nbsp; FINALS:&nbsp; FRIDAY, AUGUST 17TH !</p>
<h5><span style="color: #ff0000;"><strong>FIRST PLACE -- GRAND PRIZE!</strong></span></h5>
<p>• $2,500 CASH<br>• Your own headlining show at Jammin Java<br>• Studio time at <a href="http://www.cuerecording.com/" target="_blank">Cue Recording Studios</a> with producer Jim Ebert&nbsp;&nbsp; <br>• Gift certificate from <a href="http://www.chucklevins.com/" target="_blank">Chuck Levin's Washington Music Center</a><br>• Full Band Press-Promotional Band Shoot by <a href="http://www.snappshotphotography.com/" target="_blank">Snapp-Shot Photography, LLC</a><br>• 10 hours rehearsal studio time at <a href="http://themusicschoolonline.com/" target="_blank">The Music School</a> at Jammin Java<br>• Business card or poster design from <a href="http://bandsbyluke.com/" target="_blank">BandsByLuke</a><br>• Printing of business cards and free posters for any upcoming two shows via <a href="http://donnprint.com/" target="_blank">Donnelly's Printing</a><br>• Professional video recording of an upcoming show via <a href="http://www.peaceprofilms.com/" target="_blank">Peace Pro Films</a><br>• Full website feature with <a href="http://downloadmag.net/" target="_blank">DownloadMag.net</a></p>
<p><span style="color: #ff0000;"><strong>2nd place</strong></span><br>• Full Band Press-Promotional Band Shoot by <a href="http://marcanthonyphoto.com/index.htm" target="_blank">Mark Anthony Photography</a><br>• 4 Hours free or 25% off Single/EP Recording with <a href="http://www.sonicsweets.com/" target="_blank">Sonic Sweets Recording</a><a href="http://www.sonicrecordingstudios.com/" target="_blank"></a><br>• Gift certificate from <a href="http://www.chucklevins.com/" target="_blank">Chuck Levin's Washington Music Center</a></p>
<p><a href="http://www.chucklevins.com/" target="_blank"></a></p>
<p><span style="color: #ff0000;"><strong>3rd place</strong></span><br>• Full Band Press-Promotional Band Shoot by <a href="http://downloadmag.net/" target="_blank">DownloadMag.net</a><br>• Gift certificate from <a href="http://www.chucklevins.com/" target="_blank">Chuck Levin's Washington Music Center</a></p>
<p><span style="color: #ff0000;"><strong>4th place</strong></span><br>• Full Band Press-Promotional Band Shoot by <a href="http://downloadmag.net/" target="_blank">DownloadMag.net</a><br>• Gift certificate from <a href="http://www.chucklevins.com/" target="_blank">Chuck Levin's Washington Music Center</a></p>
<p>&nbsp;</p>
<p><span style="color: #ffffff;"><strong>Monday - July 2nd</strong></span><br>7:30-7:45 - <a href="http://www.facebook.com/threesoundband" target="_blank">Threesound</a><br>8:00-8:15 - <a href="https://www.facebook.com/westernaffairsmusic" target="_blank">Western Affairs</a><br>8:30-8:45 - <a href="http://pofemusic.com/" target="_blank">Panel of Experts</a><br>9:00-9:15 - <a href="http://www.facebook.com/brianglennonmusic" target="_blank">Brian Glennon</a><br>9:30-9:45 - <a href="http://www.the19thstreetband.com/fr_welcome.cfm" target="_blank">19th Street Band</a><br>10:00-10:15 - <a href="http://www.reverbnation.com/griswald" target="_blank">Griswald</a><br>10:30-10:45 - <a href="http://www.facebook.com/shokkher" target="_blank">Shokkher</a><br><span style="color: #ff0000;"><br><span style="color: #ffffff;"><strong>Tuesday - July 3rd</strong></span></span><br>7:30-7:45 - <br>8:00-8:15 - <a href="http://www.facebook.com/ApartOfUsAll" target="_blank">Maple</a><br>8:30-8:45 - <a href="http://www.facebook.com/HeresToYouBand" target="_blank">Here's To You</a><br>9:00-9:15 - <a href="http://www.facebook.com/DZDmusic" target="_blank">DZD</a><br>9:30-9:45 - <a href="http://www.facebook.com/overlandmusic" target="_blank">Overland </a><br>10:00-10:15 - <a href="http://www.facebook.com/pages/Singleside/180080742013136" target="_blank">Singleside</a><br>10:30-10:45 - <a href="http://www.dia2ill.com/" target="_blank">Dia2ill</a><br><br><span style="color: #ffffff;"><strong>Thursday - July 5th</strong></span><br>7:30-7:45 - <a href="https://www.facebook.com/TheDuskwhales" target="_blank">The Duskwhales&nbsp; </a><br>8:00-8:15 - <a href="http://www.facebook.com/pages/Hello-Headlights/114671038608707" target="_blank">Hello Headlights</a><br>8:30-8:45 - <a href="http://www.facebook.com/lightspeedrescue" target="_blank">Lightspeed Rescue</a><br>9:00-9:15 - <a href="http://anatoledoak.bandcamp.com/" target="_blank">Anatole Doak</a><br>9:30-9:45 - <a href="http://www.dcflow.com/index.html" target="_blank">DC Flow </a><br>10:00-10:15 - <a href="http://www.petclinicmusic.com/" target="_blank">Pet Clinic</a><br>10:30-10:45 - <a href="http://classifiedfrequency.com/" target="_blank">Classified Frequency</a><br>11:00-11:15 - <a href="http://www.hundredyardsmash.com/fr_enter.cfm" target="_blank">Hundred Yard Smash</a></p>
<p><a href="http://www.hundredyardsmash.com/fr_enter.cfm" target="_blank"><br></a><span style="color: #ff0000;"><span style="color: #ffffff;"><strong>Friday - July 6th</strong></span></span><br>7:30-7:45 - <a href="http://www.facebook.com/Paradigmsounds" target="_blank">Paradigm</a><br>8:00-8:15 - <a href="http://www.facebook.com/thebanddaybreak" target="_blank">Daybreak&nbsp; </a><br>8:30-8:45 - <a href="http://www.facebook.com/TheWillToSurvive" target="_blank">The Will To Surive</a><br>9:00-9:15 - <a href="http://www.facebook.com/pages/Flux180/158925394156494" target="_blank">Flux 180</a><br>9:30-9:45 - <a href="http://www.facebook.com/fourmilerun" target="_blank">Four Mile Run</a><br>10:00-10:15 - <a href="http://www.facebook.com/themothershipband" target="_blank">Mothership</a><br>10:30-10:45 - <a href="http://shadeparadeband.com/" target="_blank">Shade Parade</a></p>
<p>
<font color="#888888"> <a href="http://jamminjava.com/bandbattle/" target="_blank">Official Site</a> |      </font></p>

eos
eve.save!


#### 
#### Chart & Areas
####

chart = Chart.new
chart.background_image_url = '/images/jj-chart-bg.png'

seating_chart_data = SVGParser.new('./public/svg/jjchart.svg')
area_seats = seating_chart_data.area_seats
single_seats = seating_chart_data.single_seats

single_seats.each do |c|
  a = Area.new
  a.x = c[:x]
  a.y = c[:y]
  a.label_section = 'Table Seating'
  
  chart.areas << a
end

area_seats.each do |c|
  a = Area.new
  a.polypath = c[:poly]
  a.label_section = 'General Admission'
  chart.areas << a
end

eve.chart = chart
eve.save!
 
#### ###########
#### TICKETS ###
#### ###########
# Create one ticket for each single seat
# and 20 tickets for each area seat.
# Later this will be configurable by Area

eve.chart.areas.each do |area| 
  if area.type == :single
    t = Ticket.new :price => 15.00
    t.area = area
    t.state = ( rand(3) == 0 ) ? 'closed' : 'open' # randomly close 1/3 tickets
    eve.tickets << t
  elsif area.type == :area
    20.times do
      t = Ticket.new :price => 10.00
      t.area = area
      t.state = ( rand(3) == 0 ) ? 'closed' : 'open' # randomly close 1/3 tickets
      eve.tickets << t
    end
  end
end

eve.save!


#### ###########
#### EVENTS ###
#### ###########

eve = Event.new
eve.starts_at = DateTime.parse('7th July 2012 10:00:00 PM')
eve.ends_at = DateTime.parse('8th July 2012 12:00:00 AM')
eve.title = "Super Bob"
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/superbob-a_thumb.jpg'
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/superbob-a.jpg'
eve.body =   <<-eos
<p>"Going to a SUPER bob show is like getting on a f'ing roller coaster, they rock your ass off and you can't wait to get back on." -Whitney (On Air personality) DC 101</p>
<p>SUPER bob is a four-piece high energy rock band based in the Washington DC area. Childhood friends Adam Smith (guitar) and Matt Santoro (vocals) formed the band, under the name "bob" in &lsquo;05 with the vision of bringing something fresh to a rock scene that seemed to have forgotten what rock n roll was really about. Soon after, they added Drew Recny (bass) and Chris Faircloth (drums). This band breathes rebellious authenticity back into music and reminds you that rock music is supposed to make you get up and not give a damn about being you.</p>
<p>When you see SUPER bob live your senses will be overwhelmed by a borderline excess of stage presence and heart pounding sound. P.R.S sponsored guitarist Adam Smith brings a package of uniqueness, flare, and pure adrenaline that is rarely found in any one musician, while classically trained Drew Recny packs a clean, punchy bass style that is loaded with obvious talent and a technique that only comes with full dedication and commitment to his craft. Christopher Faircloth, a Spaun Drum Company sponsored drummer, brings an almost indescribable style to the table, one with high flying stick tricks, and hard pounding, ear deafening, strong beats. The proverbial icing on the SUPER bob cake is provided by Matt Santoro's vocals which can only be described as unabashedly his own. Full of ear catching melodies, unapologetic and blatantly honest lyrics, and a flow that is uncommon yet undeniably at home in rock, Santoro's songwriting couples with an unrivaled stage presence that caps off one of the best live bands you will ever get the chance to experience.</p>
<p>SUPER bob's buzz was established with their eye catching live shows, non-stop hustle, and no excuses work ethic. Tattoos, colored hair, dread locks, and plenty of good old fashioned rock n roll grit distinguishes them from the undedicated and identifies them as the real deal in an industry riddled with fakers. After three years of hard work at gaining recognition, winning the loyalty of fans in their local scene, and growing a fan-base across the Mid-Atlantic, SUPER bob hooked up with Grammy nominated producer Garth "GGGarth" Richardson. They went to Vancouver BC to record their first full length record entitled "bbbob" and then hit the road for the next three years playing an average of 130 shows annually over a span of 19 states.</p>
<p>"I have seen over 7,500 bands in the last fifteen years, and SUPER bob is one of the best. Never have I seen a band gain fans so quick and rock it on stage with such energy. They will woo grandmas to teenies" -Mick Minchow Owner/ Booking Agent/ Promoter - Ground Zero-Spartanburg SC</p>
<p>
<font color="#888888"> <a href="http://www.superbobmusic.com" target="_blank">Official Site</a> |  <a href="http://twitter.com/superbobmusic" target="_blank" title="SUPER bob Twitter page">Twitter</a> |    <a href="http://www.facebook.com/superbobmusic" target="_blank" title="View SUPER bob Facebook page">Facebook</a> |  <a href="http://click.linksynergy.com/fs-bin/stat?id=*FknwilNy5I&offerid=146261&type=3&subid=0&tmpid=1826&RD_PARM1=http%253A%252F%252Fitunes.apple.com%252Fus%252Fartist%252Fsuper-bob%252Fid382669827%253Fuo%253D4%2526partnerId%253D30" target="_blank" title="Listen to &ldquo;&rdquo; by SUPER bob">iTunes</a> |  <a href="http://www.youtube.com/user/SuperBobMusic" target="_blank" title="Watch video from SUPER bob">YouTube</a> </font></p>

<p><br /><strong><span style="color: #ffffff;">CARRY THE ONE</span></strong><br />Carry the One combines multiple musical genres to create a sound both pleasing and unique... Funk, metal, rock, hip-hop, R&amp;B, jazz, progressive/math rock, reggae, pop-punk, and so on. They strive to create a live experience which is both energetic and entertaining.<br /><a href="http://www.twitter.com/CarrytheOneBand" target="_blank">Twitter</a> | <a href="http://www.facebook.com/carrytheonemusic" target="_blank">Facebook</a></p><br />
<p><span style="color: #ffffff;"><strong>NINE DAYS GONE</strong></span><br />Frontman Joseph Keith, bass guitarist Eric Daniel, and drummer Luke P formed Nine Days Gone in 2009 The band writes and records all original material in the Washington DC area. The bands influences come from a variety of alternative/punk bands like Green Day, Sum 41, and Blink 182. Nine Days Gone started playing shows in the Fall of 2011, and since then they have gained popularity across the DC metro area. They have been privileged enough to be featured on multiple radio stations, open for major local acts, and work with renowned producer John Piette to record their second album "As It's Always Been".<br /><a href="http://www.ninedaysgone.com/" target="_blank">Official site</a> | <a href="http://www.twitter.com/NineDaysGone" target="_blank">Twitter</a> | <a href="http://www.facebook.com/#!/pages/Nine-Days-Gone/177583798985165?sk=wall&amp;filter=1" target="_blank">Facebook</a> | <a href="http://click.linksynergy.com/fs-bin/stat?id=*FknwilNy5I&amp;offerid=146261&amp;type=3&amp;subid=0&amp;tmpid=1826&amp;RD_PARM1=http%253A%252F%252Fitunes.apple.com%252Fus%252Fartist%252Fnine-days-gone%252Fid460460342%253Fuo%253D4%2526partnerId%253D30" target="_blank">Itunes</a> | <a href="http://www.ninedaysgone.com/img/youtube_logo.jpg" target="_blank">Youtube</a></p><br />
<p>&nbsp;</p>

eos
eve.save!


eve = Event.new
eve.title = 'SOAR PRESENTS ILUVATAR'
eve.starts_at = DateTime.parse('7th July 2012 7:00:00 PM')
eve.ends_at = DateTime.parse('7th July 2012 10:00:00 PM')
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/Iluvatar-z_thumb.jpg'
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/Iluvatar-z.jpg'


eve.body = <<-eos
<p>A rare chance to see the progressive rock band Iluvatar performing new material from their upcoming release plus their classics from all 4 of their CDs!! The band has a renewed energy with a new lead vocalist.</p>
<p>Perhaps no other American band is so adept at the vintage British progressive rock formula as the Baltimore, Maryland based band Iluvatar.  Named after a chacter in J.R.R. Tolkien's The Simarillion, Iluvatar has been thrilling audiences since 1992 with their song based art rock format featuring superb lyrics and excellent musicianship.  Iluvatar are Dennis Mullen (guitar), Jim Rezek (keyboards), Chris Mack (drums), Dean Morekas (bass) and Jeff Sirody (vocals).  We are delighted to bring this finest of American progressive bands to Jammin Java where they will be debuting their newest CD.</p>
<p>The band is generally compared to the sounds of Rush, Kansas, Genesis, Marillion, etc. but developed their own sound many moons ago.</p>
<p>Iluvatar began performing live in the Baltimore area in 1992 and quickly acquired a steadily-growing following of devoted fans. Though the primary focus of their live performances was on their original compositions, the band occasionally accented their sets with music from Genesis, Marillion, Pink Floyd, and Styx.</p>
<p>Iluvatar's self-titled debut CD was released on Kinesis Records in November 1993 and quickly became the label's top-seller. Iluvatar soon began to receive international recognition for their work. Iluvatar re-entered the studio in March 1995 to record "Children", their second album for Kinesis . "Children" firmly established Iluvatar as one of the premier American bands in the 90's progressive movement. In 1997 the "Sideshow" CD, a collection of live tracks, alternate versions, and unreleased material was released. The latest studio CD "A Story Two Days Wide" was released in 1999. The band has continued to write and record since then and a new CD is due out soon.</p>
eos
eve.save!


eve = Event.new
eve.title = 'Randy Thompson Band'
eve.headline = '+ Caitlin Schneiderman'
eve.starts_at = DateTime.parse('8th July 2012 8:00:00 PM')
eve.ends_at = DateTime.parse('7th July 2012 10:00:00 PM')
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/Randy_Thompson-a_thumb.jpg'
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/Randy_Thompson-a.jpg'


eve.body = <<-eos
<p>A rare chance to see the progressive rock band Iluvatar performing new material from their upcoming release plus their classics from all 4 of their CDs!! The band has a renewed energy with a new lead vocalist.</p>
<p>Perhaps no other American band is so adept at the vintage British progressive rock formula as the Baltimore, Maryland based band Iluvatar.  Named after a chacter in J.R.R. Tolkien's The Simarillion, Iluvatar has been thrilling audiences since 1992 with their song based art rock format featuring superb lyrics and excellent musicianship.  Iluvatar are Dennis Mullen (guitar), Jim Rezek (keyboards), Chris Mack (drums), Dean Morekas (bass) and Jeff Sirody (vocals).  We are delighted to bring this finest of American progressive bands to Jammin Java where they will be debuting their newest CD.</p>
<p>The band is generally compared to the sounds of Rush, Kansas, Genesis, Marillion, etc. but developed their own sound many moons ago.</p>
<p>Iluvatar began performing live in the Baltimore area in 1992 and quickly acquired a steadily-growing following of devoted fans. Though the primary focus of their live performances was on their original compositions, the band occasionally accented their sets with music from Genesis, Marillion, Pink Floyd, and Styx.</p>
<p>Iluvatar's self-titled debut CD was released on Kinesis Records in November 1993 and quickly became the label's top-seller. Iluvatar soon began to receive international recognition for their work. Iluvatar re-entered the studio in March 1995 to record "Children", their second album for Kinesis . "Children" firmly established Iluvatar as one of the premier American bands in the 90's progressive movement. In 1997 the "Sideshow" CD, a collection of live tracks, alternate versions, and unreleased material was released. The latest studio CD "A Story Two Days Wide" was released in 1999. The band has continued to write and record since then and a new CD is due out soon.</p>
eos
eve.save!

eve = Event.new
eve.title = 'Randy Thompson Band'
eve.headline = '+ Final Voyage + WATSB + Merrin Karas + Swell Daze'
eve.starts_at = DateTime.parse('9th July 2012 6:30:00 PM')
eve.ends_at = DateTime.parse('9th July 2012 8:30:00 PM')
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/JJDoorGal-automatics_thumb.jpg'
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/Randy_Thompson-a.jpg'


eve.body = <<-eos
<p>A rare chance to see the progressive rock band Iluvatar performing new material from their upcoming release plus their classics from all 4 of their CDs!! The band has a renewed energy with a new lead vocalist.</p>
<p>Perhaps no other American band is so adept at the vintage British progressive rock formula as the Baltimore, Maryland based band Iluvatar.  Named after a chacter in J.R.R. Tolkien's The Simarillion, Iluvatar has been thrilling audiences since 1992 with their song based art rock format featuring superb lyrics and excellent musicianship.  Iluvatar are Dennis Mullen (guitar), Jim Rezek (keyboards), Chris Mack (drums), Dean Morekas (bass) and Jeff Sirody (vocals).  We are delighted to bring this finest of American progressive bands to Jammin Java where they will be debuting their newest CD.</p>
<p>The band is generally compared to the sounds of Rush, Kansas, Genesis, Marillion, etc. but developed their own sound many moons ago.</p>
<p>Iluvatar began performing live in the Baltimore area in 1992 and quickly acquired a steadily-growing following of devoted fans. Though the primary focus of their live performances was on their original compositions, the band occasionally accented their sets with music from Genesis, Marillion, Pink Floyd, and Styx.</p>
<p>Iluvatar's self-titled debut CD was released on Kinesis Records in November 1993 and quickly became the label's top-seller. Iluvatar soon began to receive international recognition for their work. Iluvatar re-entered the studio in March 1995 to record "Children", their second album for Kinesis . "Children" firmly established Iluvatar as one of the premier American bands in the 90's progressive movement. In 1997 the "Sideshow" CD, a collection of live tracks, alternate versions, and unreleased material was released. The latest studio CD "A Story Two Days Wide" was released in 1999. The band has continued to write and record since then and a new CD is due out soon.</p>
eos
eve.save!


