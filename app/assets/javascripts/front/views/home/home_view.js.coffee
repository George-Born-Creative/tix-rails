class Tix.Views.HomeView extends Backbone.View
  template: JST['front/templates/home/home']

  initialize: ->
    
  render: ->
    @$el.html @template()
    @