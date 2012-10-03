class Tix.Views.PageView extends Backbone.View
  

  initialize: (jst_template)->
    console.log 
    @template = JST[jst_template]
    
  leave: ->
    this.remove()
    
  render: ->
    @$el.html @template()
    @