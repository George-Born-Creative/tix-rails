Time::DATE_FORMATS[:month_and_year] = "%B %Y"
Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }
Time::DATE_FORMATS[:jammin_java] = '%A %B %-d, %Y %l:%m%P'
Time::DATE_FORMATS[:jammin_java_short] = '%a %b %-d, %Y %l:%m%P'

Time::DATE_FORMATS[:shorty] = '%a %m-%d-%Y %l:%M %p'

Time::DATE_FORMATS[:weekday] = "%A"
Time::DATE_FORMATS[:date] = "%Y-%m-%d"
Time::DATE_FORMATS[:date_y] = "%m-%d-%Y"
Time::DATE_FORMATS[:date_slashes] = "%m/%d/%Y"

Time::DATE_FORMATS[:time] = "%l:%M %p"

Time::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M"