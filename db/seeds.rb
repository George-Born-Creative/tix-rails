# -*- encoding : utf-8 -*-
require 'json'
require './lib/svg_parser'
require 'date'

Event.delete_all
Ticket.delete_all
Area.delete_all
Chart.delete_all


#### 
#### Chart & Areas
####
def generate_chart
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
  return chart
end # generate_chart

 
#### ###########
#### TICKETS ###
#### ###########
# Create one ticket for each single seat
# and 20 tickets for each area seat.
# Later this will be configurable by Area

def generate_tickets(eve, chart)
  eve.chart.areas.each do |area| 
    if area.type == :single
      t = Ticket.new :price => 15.00
      t.area = area
      t.state = ( rand(3) == 0 ) ? 'closed' : 'open' # randomly close 1/3 tickets
      eve.tickets << t
    elsif area.type == :area
      50.times do
        t = Ticket.new :price => 10.00
        t.area = area
        t.state = ( rand(3) == 0 ) ? 'closed' : 'open' # randomly close 1/3 tickets
        eve.tickets << t
      end
    end
  end
end



#### ###########
#### EVENTS ###
#### ###########

eve = Event.new
eve.starts_at = DateTime.parse('16th July 2012 8:00:00 PM')
eve.ends_at = DateTime.parse('16th July 2012 10:00:00 AM')

eve.title = "Hank and Cupcakes"
eve.headline = '+ Sonic Nights + The Silent Critics '
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/HankCupcakes-z.jpg'
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/HankCupcakes-z_thumb.jpg'
eve.body =   <<-eos
<p>After kicking off 2012 in the most incredible way - by opening a sold-out show for Deadmau5 at NYC's Pier 36, the dynamic twosome is tearing full-speed ahead with the release of their debut album titled NAKED, recorded last summer at the famous Hansa Studios in Berlin (U2, David Bowie, Iggy Pop). "Liquid Mercury" the album's first single appeared in Billboard Magazine's Top 40 Indicator Highlights after climbing to the #37 position on the Indicator Charts, making Hank &amp; Cupcakes the highest unsigned band on the chart. The band has also played select dates across Europe and the Middle East so far this year, including playing to a crowds of over 2,000 in Barcelona and 700 in Stockholm and are 'Getting NAKED on the road' as they put it, this summer, with over 30 tour dates across the US. Incessant action and whirlwind touring are nothing new to Hank &amp; Cupcakes, who formed in Tel Aviv just prior to moving to Cuba where they spent six months of musical exploration. The duo ended up in Williamsburg, Brooklyn almost two years ago, drawn by what Cupcakes describes as "the music, the streets, the energy, the electricity and the nonstop movement of NYC... We feel we can't just sit still here and have the urge to be in constant musical motion." But if these two feel drawn to NYC, it's clear that the city strongly reciprocates that very sentiment.</p>
eos
eve.chart = generate_chart
generate_tickets(eve, eve.chart)
eve.save!


eve = Event.new
eve.starts_at = DateTime.parse('17th July 2012 7:30:00 PM')
eve.ends_at = DateTime.parse('17th July 2012 12:00:00 AM')
eve.title = "Teddy Geiger"
eve.headline = '+ Jesse Ruben + Sarah Miles'
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/TEDDY_GEIGER-z.jpg'
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/TEDDY_GEIGER-z_thumb.jpg'
eve.body =   <<-eos
<p><strong>Be one of the 10 lucky ticket holders to be selected for an Early Access/Meet &amp; Greet with Teddy Geiger.&nbsp;Purchase advance tickets <a href="http://jamminjava.3dcartstores.com/product.asp?itemid=2030" target="_blank">online </a>or via phone at 703.255.1566. Deadline to qualify is July 16th at 10:30am.</strong></p>
<p><strong><br /></strong></p>
<p>American singer-songwriter Teddy Geiger first catapulted onto the national stage in March 2006 when his debut album, the critically-acclaimed "Underage Thinking," entered the Billboard Top 200 at #8 and yielded a million-selling Hot AC Top 10 single -- "For You I Will" -- when Teddy was just 16.</p>
<p>This year Teddy is recording and releasing his new album, The Last Fears, exclusively through Pledge Music at <a href="http://www.pledgemusic.com/projects/teddygeiger" target="_blank">www.pledgemusic.com/teddygeige</a>r where fans are invited to help play an integral part in making the album.</p>
<p>Proficient on a number of instruments including guitar, bass, piano and drums, Geiger had first made his reputation as a musician in high school when gigs around his native Rochester, New York, earned the loyalty of an ever-growing fanbase of self-proclaimed "Ted-Heads." While an internet fan buzz fueled his early burgeoning popularity, Teddy's first independent release, the regional EP "Stepladder" (on Cred Records), peaked at #1 in Rochester and made the Top 10 in Billboard's mid-Atlantic regional "Heatseekers" chart, leading to a deal with Columbia Records.</p>
<p>Teddy's debut album, "Underage Thinking," was both a popular and critical success.  "Teddy Geiger projects an easy charm along with his real pop chops," raved The New York Times while People magazine, in a three-and-a-half star "Critic's Choice" review, predicted that "Teddy Geiger should have a long career ahead of him."</p>
<p>Teddy's dynamic new school pop, informed by the spirit of rock's glory days, earned him spots on shows featuring Gavin DeGraw, Kelly Clarkson, and Hilary Duff's #1 pop tour.  Teddy has shared bills with Brandi Carlile, Pete Yorn, Simple Plan, Fall Out Boy, Frankie J, Jesse McCartney, The Click 5, among others.  Teddy's breakout year closed with the artist becoming the first male to grace the cover of Seventeen magazine in five years.</p>
<p>Teddy -- who had a dramatic role as an emerging young singer-songwriter in "Love Monkey," the short-lived CBS cult television series (later picked up by VH1) -- made his big screen debut in 2008's "The Rocker," a summer comedy starring Rainn Wilson and Christina Applegate which premiered a number of new Teddy Geiger performances in its soundtrack.</p>
<p>Since the release of "The Rocker," Teddy Geiger moved to New York City and began writing the songs at the core of The Last Fears. New compositions and performances include "Shake It Off," "Magic," "Home," "Ordinary Man," "One More Night," and "Walking In The Sun". The album has a sound not dissimilar from his debut but also showcases both his maturity and depth as a songwriter and craftsman.</p>
<p><br /><strong><span style="color: #ffffff;">CARRY THE ONE</span></strong><br />Carry the One combines multiple musical genres to create a sound both pleasing and unique... Funk, metal, rock, hip-hop, R&amp;B, jazz, progressive/math rock, reggae, pop-punk, and so on. They strive to create a live experience which is both energetic and entertaining.<br /><a href="http://www.twitter.com/CarrytheOneBand" target="_blank">Twitter</a> | <a href="http://www.facebook.com/carrytheonemusic" target="_blank">Facebook</a></p><br />
<p><span style="color: #ffffff;"><strong>NINE DAYS GONE</strong></span><br />Frontman Joseph Keith, bass guitarist Eric Daniel, and drummer Luke P formed Nine Days Gone in 2009 The band writes and records all original material in the Washington DC area. The bands influences come from a variety of alternative/punk bands like Green Day, Sum 41, and Blink 182. Nine Days Gone started playing shows in the Fall of 2011, and since then they have gained popularity across the DC metro area. They have been privileged enough to be featured on multiple radio stations, open for major local acts, and work with renowned producer John Piette to record their second album "As It's Always Been".<br /><a href="http://www.ninedaysgone.com/" target="_blank">Official site</a> | <a href="http://www.twitter.com/NineDaysGone" target="_blank">Twitter</a> | <a href="http://www.facebook.com/#!/pages/Nine-Days-Gone/177583798985165?sk=wall&amp;filter=1" target="_blank">Facebook</a> | <a href="http://click.linksynergy.com/fs-bin/stat?id=*FknwilNy5I&amp;offerid=146261&amp;type=3&amp;subid=0&amp;tmpid=1826&amp;RD_PARM1=http%253A%252F%252Fitunes.apple.com%252Fus%252Fartist%252Fnine-days-gone%252Fid460460342%253Fuo%253D4%2526partnerId%253D30" target="_blank">Itunes</a> | <a href="http://www.ninedaysgone.com/img/youtube_logo.jpg" target="_blank">Youtube</a></p><br />
<p>&nbsp;</p>

eos
eve.chart = generate_chart
generate_tickets(eve, eve.chart)
eve.save!


eve = Event.new
eve.title = 'Mindy Smith CD Release'
eve.headline = "+ Rosi Golan"
eve.starts_at = DateTime.parse('18th July 2012 8:00:00 PM')
eve.ends_at = DateTime.parse('18th July 2012 10:00:00 PM')
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/MindySmith-y_thumb.jpg'
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/MindySmith-y.jpg'


eve.body = <<-eos
<p>Known for her "smartly written folk and country-tinged tunes" (People) and "her bright soprano..." (Rolling Stone), critically lauded Nashville-based singer-songwriter Mindy Smith will self-release her fifth studio album on Giant Leap/TVX Records June 26. The self-titled effort is her first album of new material since 2009's Stupid Love and her first as an independent artist. Returning to the sound of her first two albums, "...her music has a reflective surface that can make it difficult to look inside" (Nashville Scene), Mindy Smith further showcases her timeless sound and music.</p>
<p>Of "Closer," Mindy says, "Many times in life's journey, we find ourselves disoriented. For me, I make destructive decisions that can distract me from my ultimate goal. I think I am making the right choices and staying close to my agenda but I just run off course. In "Closer," I see the North Star as the prize. One that I am always getting so close to but unable to grab a hold of and then it eludes me. Personally this song paints a picture of how I see my musical career and that I see NOW is my moment. Taking the time to listen for the answers to my questions. I guess NOW is always our moment even if it is only etching out one little piece of the bigger picture."</p>
<p>Co-produced with Jason Lehning, the collection features 11 original compositions-seven of which Smith wrote with the remaining four as co-writes. Recorded at Sound Emporium Studio in Nashville, the album features some of Nashville best players, including Bryan Sutton (guitar); Lex Price (bass); Ian Fitchuk (drums); and Joe Pisapia (guitar), Jason Lehning (guitar), and Dan Dugmore (pedal steel). Prior to the release of her 2004 debut, the New York native charmed fans with her rendition of Dolly Parton's "Jolene," for the much-praised Dolly Parton tribute album, Just Because I'm a Woman. Her Vanguard Records debut album, One Moment More, went on to earn numerous critical accolades, featured the hit single "Come to Jesus," and sold over 300,000 copies. She subsequently released Long Island Shores (Vanguard, 2006), My Holiday (Vanguard, 2007), and Stupid Love (Vanguard, 2009).</p>
<p>In August 2011, Mindy and longtime friend Daniel Tashian recorded "Taking You With Me," a duet featured in the film and soundtrack for Paul Rudd's film Our Idiot Brother. Her music's also been featured in national television shows such as Grey's Anatomy, HBO's Six Feet Under and the WB's Smallville and Summerland.</p>eos
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
eve.chart = generate_chart
generate_tickets(eve, eve.chart)
eve.save!

eve = Event.new
eve.title = 'Randy Thompson Band'
eve.headline = '+ Final Voyage + WATSB + Merrin Karas + Swell Daze'
eve.starts_at = DateTime.parse('9th July 2012 6:30:00 PM')
eve.ends_at = DateTime.parse('9th July 2012 8:30:00 PM')
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/JJDoorGal-automatics_thumb.jpg'
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/Randy_Thompson-a.jpg'


eve.body = <<-eos
<p>A rare chance to see the progressive rock band Iluvatar performing new material from their upcoming release plus their classics from all 4 of their CDs!! The band has a renewed energy with a new lead vocalist.</p>
<p>Perhaps no other American band is so adept at the vintage British progressive rock formula as the Baltimore, Maryland based band Iluvatar.  Named after a chacter in J.R.R. Tolkien's The Simarillion, Iluvatar has been thrilling audiences since 1992 with their song based art rock format featuring superb lyrics and excellent musicianship.  Iluvatar are Dennis Mullen (guitar), Jim Rezek (keyboards), Chris Mack (drums), Dean Morekas (bass) and Jeff Sirody (vocals).  We are delighted to bring this finest of American progressive bands to Jammin Java where they will be debuting their newest CD.</p>
<p>The band is generally compared to the sounds of Rush, Kansas, Genesis, Marillion, etc. but developed their own sound many moons ago.</p>
<p>Iluvatar began performing live in the Baltimore area in 1992 and quickly acquired a steadily-growing following of devoted fans. Though the primary focus of their live performances was on their original compositions, the band occasionally accented their sets with music from Genesis, Marillion, Pink Floyd, and Styx.</p>
<p>Iluvatar's self-titled debut CD was released on Kinesis Records in November 1993 and quickly became the label's top-seller. Iluvatar soon began to receive international recognition for their work. Iluvatar re-entered the studio in March 1995 to record "Children", their second album for Kinesis . "Children" firmly established Iluvatar as one of the premier American bands in the 90's progressive movement. In 1997 the "Sideshow" CD, a collection of live tracks, alternate versions, and unreleased material was released. The latest studio CD "A Story Two Days Wide" was released in 1999. The band has continued to write and record since then and a new CD is due out soon.</p>
eos
eve.chart = generate_chart
generate_tickets(eve, eve.chart)
eve.save!

#############
#############

eve = Event.new
eve.title = 'Cerca Trova'
eve.headline = '+ Daughter of Stars + Everything Falls'
eve.starts_at = DateTime.parse('20th July 2012 10:30:00 PM')
eve.ends_at = DateTime.parse('20th July 2012 11:59:00 PM')
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/CercaTrova-y.jpg'
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/Randy_Thompson-a.jpg'

eve.body = <<-eos
<p>Some people spend their entirely life searching, very few stop and listen, in this malleable world.They fail to realize the importance of what goes on around them.  The sound, the feeling, the edge, the music.  It's all lost in the drone of their ever-busy lives.  Deadlines and formats seem to rule the world.  However, all it takes is one step, one reach, one song to break through to the hearts of the people."Cerca Trova."  Some people spend their entire lives searching.  Searching for love, purpose, and happiness.  "He who seeks, shall find."  Since 2005, Cerca Trova has also been searching.  Across some lineup changes, a few EP releases, and copious amounts of dedication, progress is finally made. Yet the journey is not even close to being over.  Through hard-hitting drums, face-melting guitar, heart-driving bass, and soul-piercing vocals, one will begin to finally understand the meaning of Cerca Trova. Join them in the search for what sets us apart from amoebas, real music. Relentless Rock n' Roll.  American Rock n' Roll.</p>
eos
eve.chart = generate_chart
generate_tickets(eve, eve.chart)
eve.save!

#############
#############

eve = Event.new
eve.title = 'Mamas Black Sheep + Christine Havrilla'
eve.starts_at = DateTime.parse('19th July 2012 7:30:00 PM')
eve.ends_at = DateTime.parse('19th July 2012 9:30:00 PM')
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/MamasBlackSheep+Christine_Havrilla_-z.jpg'
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/MamasBlackSheep+Christine_Havrilla_-z_thumb.jpg'

eve.body = <<-eos
<p>Some people spend their entirely life searching, very few stop and listen, in this malleable world.They fail to realize the importance of what goes on around them.  The sound, the feeling, the edge, the music.  It's all lost in the drone of their ever-busy lives.  Deadlines and formats seem to rule the world.  However, all it takes is one step, one reach, one song to break through to the hearts of the people."Cerca Trova."  Some people spend their entire lives searching.  Searching for love, purpose, and happiness.  "He who seeks, shall find."  Since 2005, Cerca Trova has also been searching.  Across some lineup changes, a few EP releases, and copious amounts of dedication, progress is finally made. Yet the journey is not even close to being over.  Through hard-hitting drums, face-melting guitar, heart-driving bass, and soul-piercing vocals, one will begin to finally understand the meaning of Cerca Trova. Join them in the search for what sets us apart from amoebas, real music. Relentless Rock n' Roll.  American Rock n' Roll.</p>
eos

eve.chart = generate_chart
generate_tickets(eve, eve.chart)
eve.save!


#############
#############

eve = Event.new
eve.title = 'An Evening with Todd Wright and Cassidy Ford'
eve.starts_at = DateTime.parse('21th July 2012 7:00:00 PM')
eve.ends_at = DateTime.parse('19th July 2012 7:30:00 PM')
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/ToddWright+CassidyFord.jpg'
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/ToddWright+CassidyFord_thumb.jpg'

eve.body = <<-eos
<p>Todd Wright started this century as the touring guitarist for then-Atlantic-now-Verve recording artist Lucy Woodward. From 2004-2006 he was the touring keyboardist for Warner Brothers recording artist Pat McGee whom Wright later co-wrote and produced "These Days - The Virginia Sessions" for. In 2008 he signed a publishing deal with Warner Chappell music publishing and with his writing partner Scott Simons wrote songs for a real housewife of Orange County, a Dutch Idol (Lisa Lois - Sony), a Eurovision Song Contest winner (Lena - Universal) and Judy Garland's grandniece (Audra Mae - Sideonedummy). After leaving Warner in 2009 Wright helped develop local DC artist Chelsea Lee and was instrumental in her signing to Atlantic Records. Four of his songs are on Lee's upcoming Atlantic release. In 2010 Wright signed with Pen music publishing and has since placed songs on TV shows Bones (FOX) and One Tree Hill (CW) as well as an upcoming major motion picture called What's Your Number.Todd is also endlessly wrapped up in various side projects including a power-pop-electronic band with ex-Atlantic recording artist Toby Lightman called Girl Named Toby. He also has a trio with Better Than Ezra bassist Tom Drummond and America's Next Top Model winner CariDee English called Broken English. In his 39th year Wright completed a project called 40x40 where he wrote and released a song every week for 40 weeks culminating on his 40th birthday. The project was participated in by many of Todd's musical buds including members of Collective Soul, Better Than Ezra, The New York Dolls and Taylor Swift's band. One of these songs (Lay Down) was re-mixed by internationally loved producers Roger Shah, Ross Lara and Johnny Yono and reached #18 on the Beatport charts. All of the proceeds raised by 40x40 were donated to Juvenile Diabetes research.</p>
eos

eve.chart = generate_chart
generate_tickets(eve, eve.chart)
eve.save!


#############
#############

eve = Event.new
eve.title = 'Gold Motel'
eve.headline = '+ von Grey + A City On A Lake'
eve.starts_at = DateTime.parse('23rd July 2012 8:00:00 PM')
eve.ends_at = DateTime.parse('23rd July 2012 7:30:00 PM')
eve.image_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/GoldMotel.jpg'
eve.image_thumb_uri = 'http://jamminjava.com/ee-assets/gallery/artists/adult-artists/GoldMotel_thumb.jpg'

eve.body = <<-eos
<p>Todd Wright started this century as the touring guitarist for then-Atlantic-now-Verve recording artist Lucy Woodward. From 2004-2006 he was the touring keyboardist for Warner Brothers recording artist Pat McGee whom Wright later co-wrote and produced "These Days - The Virginia Sessions" for. In 2008 he signed a publishing deal with Warner Chappell music publishing and with his writing partner Scott Simons wrote songs for a real housewife of Orange County, a Dutch Idol (Lisa Lois - Sony), a Eurovision Song Contest winner (Lena - Universal) and Judy Garland's grandniece (Audra Mae - Sideonedummy). After leaving Warner in 2009 Wright helped develop local DC artist Chelsea Lee and was instrumental in her signing to Atlantic Records. Four of his songs are on Lee's upcoming Atlantic release. In 2010 Wright signed with Pen music publishing and has since placed songs on TV shows Bones (FOX) and One Tree Hill (CW) as well as an upcoming major motion picture called What's Your Number.Todd is also endlessly wrapped up in various side projects including a power-pop-electronic band with ex-Atlantic recording artist Toby Lightman called Girl Named Toby. He also has a trio with Better Than Ezra bassist Tom Drummond and America's Next Top Model winner CariDee English called Broken English. In his 39th year Wright completed a project called 40x40 where he wrote and released a song every week for 40 weeks culminating on his 40th birthday. The project was participated in by many of Todd's musical buds including members of Collective Soul, Better Than Ezra, The New York Dolls and Taylor Swift's band. One of these songs (Lay Down) was re-mixed by internationally loved producers Roger Shah, Ross Lara and Johnny Yono and reached #18 on the Beatport charts. All of the proceeds raised by 40x40 were donated to Juvenile Diabetes research.</p>
eos

eve.chart = generate_chart
generate_tickets(eve, eve.chart)
eve.save!







