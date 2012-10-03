class Tix.Views.ArtistDetailiew extends Backbone.View
  template: JST['front/templates/artist/artist_detail']

  initialize: ->
    
  render: ->
    @$el.html @template( artist: @model)
    @