class Tix.Views.EventsListView extends Backbone.View
  el: $('#events_list')
  
  initialize: ->
    
    _.bindAll this, 'setupEventListViews'
    
    this.setupEventListViews()
  
          
  render: ->


  setupEventListViews: ->
    self = this
    _.each this.collection.models, (item, idx)->
      eventView = new Tix.Views.EventListView(model: item)
      renderedEventView = eventView.render()
      #console.log renderedEventView
      $(self.el).append(renderedEventView)