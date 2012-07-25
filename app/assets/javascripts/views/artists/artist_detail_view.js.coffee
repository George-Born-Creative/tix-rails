class Tix.Views.ArtistDetailiew extends Backbone.View
  template: JST['artist/artist_detail']

  initialize: ->
    
  render: ->
    @$el.html @template( artist: @model)
    @