class Tix.Models.Seat extends Backbone.Model  

  url: ->
    area_id = @get('area').id
    return '/orders/add_to_cart/' + area_id
  
  toJSON: ->
    return {ticket: _.clone( this.attributes )}