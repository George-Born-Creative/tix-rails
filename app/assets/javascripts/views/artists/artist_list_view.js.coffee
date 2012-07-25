class Tix.Views.ArtistListView extends Backbone.View
  className: 'artist_list'
  
  
  events:
    'click': 'artistClick'
  
  template: JST['artist/artist_list']
  
  render: ->
    @$el.html( @template( artist: @model ))
    @
  
  leave: ->
    this.off()
    this.remove()

  artistClick: ->
    Tix.router.navigate '#/artist/' + this.model.id