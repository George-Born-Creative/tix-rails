class Tix.Models.Ticket extends Backbone.Model  
  
  initialize: (timer=true)->
    _.bindAll this, 'startTimer'
    @min = 5
    @sec = 0
    #_.bindAll this,
    
  
  get: (attr) ->
    return this[attr]() if (typeof this[attr] == 'function')
    return Backbone.Model.prototype.get.call(this, attr)
  
  formattedPrice: ->
    price = this.get('price')
    return Tix.utils.formatCurrency(price) 
    
  startTimer: ->
    self = this
    @timer = window.setInterval ->
      self.countDown()
    , 1000
    
  countDown: ->
    @sec--
    if parseInt( @sec) is -1
      @sec = 59
      @min = parseInt(@min) - 1
    else
      @min = @min
    @sec = "0" + @sec  if parseInt( @sec) <= 9
    time = (if @min <= 9 then "0" + @min else @min) + ":" + @sec + ""
    if parseInt(@min) is 0 and parseInt(@sec) is 0
      @sec = "00"
      window.clearTimeout @timer
      this.trigger 'expire', {time: time}
    this.trigger 'tick', {time: time}
    
    # TODO... fire 1 minute warning so UI can respond
