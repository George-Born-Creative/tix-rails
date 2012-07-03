# -*- encoding : utf-8 -*-
require 'json'
require './lib/svg_parser'
require 'date'


#### 
#### Event
####

Event.delete_all
eve = Event.create
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
  chart.areas << a
end

area_seats.each do |c|
  a = Area.new
  a.polypath = c[:poly]
  chart.areas << a
end

eve.chart = chart
eve.save!


