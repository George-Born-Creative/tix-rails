class TixMgr.Views.WidgetView extends Backbone.View
  
  template: JST['manager/templates/widget']
  
  initialize: (data)->
    @title = data.title
    @content = data.content
    
  render: ->
    @$el.html(@template({ title: @title}) )
    _.each @content, (item)->
      @$el.find('.widget-content').append(item)
    , this
    @
