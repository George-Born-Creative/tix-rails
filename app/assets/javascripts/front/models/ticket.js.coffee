class Tix.Models.Ticket extends Backbone.Model  
  urlRoot: '/api/tickets'

  toJSON: ->
    return {ticket: _.clone( this.attributes )}