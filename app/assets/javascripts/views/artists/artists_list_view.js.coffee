class Tix.Views.ArtistsListView extends Backbone.View
  
  className: 'artists_list'
  
  initialize: ->
    
    _.bindAll this, 'setupArtistViews', 'artistClick'
  
    @setupSearchBox()
    @views = []
    @terms = []
    
  events: ->
    'keyup input.search' : 'searchBoxKeyUp'
    'click .artist' : 'artistClick'
    
  leave: ->
    this.off()
    this.remove()
    _.each @views, (view)-> 
  
    
  render: ->
    
    @setupArtistViews()
    @setupLiveSearch()
    #console.log [@views, @terms]
    
    @
  
  artistClick: ->
    self = this
    Tix.router.navigate this.$el.find('a').attr('href')
  
  setupLiveSearch: ->
    self = this
    _.each this.collection.models, (artist, idx)->
      self.terms.push( artist.get('name').toLowerCase() )
    
  setupSearchBox: ->
    $('<div><input style="width: 100%" type=text class=search placeholder="type to search for artists..."></input></div>')
      .addClass('g8 col offset-by-four')
      .appendTo(@$el)
    @searchBox = @$el.find('.search')
    @searchBox.focus()
    
  searchBoxKeyUp: (e)->
    self = this
    term = $.trim @searchBox.val().toLowerCase()
    scores = []
    
    if not term
      _.each @views, (view)-> view.$el.show()
    else
      _.each @views, (view)-> view.$el.hide()
      
    _.each @terms, (cached_term, idx)->
      score = cached_term.score(term)
      # console.log [term, cached_term, 'score', score]
      
      if score > 0
        scores.push [score, idx]
      
    sorted_scores = scores.sort (a, b)->
      return b[0] - a[0]
        
    _.each sorted_scores, (scores) ->
      self.views[scores[1]].$el.show()
      
    
  setupArtistViews: ->
     self = this
     _.each this.collection.models, (artist, idx)->
     
       view = new Tix.Views.ArtistListView(model: artist)
       renderedView = view.render()
       self.views.push(view)
       
       $(self.el).append(renderedView.$el)