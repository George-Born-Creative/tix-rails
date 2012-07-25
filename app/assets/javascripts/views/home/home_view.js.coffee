class Tix.Views.HomeView extends Backbone.View
  template: JST['home/home']

  initialize: ->
    
  render: ->
    @$el.html @template()
    @