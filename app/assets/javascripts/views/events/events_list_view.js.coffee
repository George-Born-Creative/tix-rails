class Tix.Views.EventsListView extends Backbone.View
  
  className: 'events_list'
  
  initialize: ->
    
    _.bindAll this, 'setupEventListViews'

  render: ->
    @setupEventListViews()
    @
    

  setupEventListViews: ->
    self = this
    _.each this.collection.models, (item, idx)->

      eventView = new Tix.Views.EventListView(model: item)
      renderedEventView = eventView.render()
      
      $(self.el).append(renderedEventView.$el)