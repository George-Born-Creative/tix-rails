# Triggers a dispatcher 'tick' as time chan

class TixLib.Timer
    
  init: (seconds_from_now)->

    @clearTimer()
    
    # console.log ['TixLib.Timer initialized with seconds_from_now=', seconds_from_now]
    
    # http://stackoverflow.com/questions/3733227/javascript-seconds-to-minutes-and-seconds

    @min = Math.floor(seconds_from_now / 60)
    @sec = seconds_from_now - ( @min * 60 )
    @start() # starts timer

    
  clearTimer: ->
    if @timer
      window.clearInterval( @timer )
    
  stop: ->
    @clearTimer()
  
  start: ->
    self = this
    @timer = window.setInterval ->
      self.countDown()
    , 1000
    
  trigger: (key, data)->
    TixLib.Dispatcher.trigger key, data
    # console.log ['trigger:', key, data.time]
      
      
  countDown: ->
    @sec--
  
    if parseInt(@min) is 1 and parseInt(@sec) is 0
      this.trigger 'warning', {time: time}
  
    if parseInt(@min) is 0 and parseInt(@sec) is 0
      @sec = "00"
      window.clearTimeout @timer
      this.trigger 'expire', {time: time}
    
  
    if parseInt( @sec) is -1
      @sec = 59
      @min = parseInt(@min) - 1
    
    else
      @min = @min
    @sec = "0" + @sec  if parseInt( @sec) <= 9
    # With leading zero on minutes
    # time = (if @min <= 9 then "0" + @min else @min) + ":" + @sec + ""
    time = @min + ":" + @sec + ""
  
    @trigger( 'tick', {time: time} )
    time