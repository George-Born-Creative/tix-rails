class Tix.Views.AppView extends Backbone.View
  el: $('body')
  
  initialize: ()->
    $('#logo').click ->
      Tix.router.navigate '#/'