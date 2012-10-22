class Tix.Models.Seat extends Backbone.Model  
  urlRoot: '/api/seat'

  toJSON: ->
    return {ticket: _.clone( this.attributes )}