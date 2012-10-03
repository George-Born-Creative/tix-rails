class TixMgr.Views.ImagesIndexView extends Backbone.View
  
  # template: JST['manager/templates/widget']
  events: ->
    
  initialize: (data)->
    console.log '[SR] TixMgr.Views.ImagesIndexView initialized'
    # @title = data.title
    # @content = data.content
    @initTokenInput()
    
  render: ->
    console.log '[SR] TixMgr.Views.ImagesIndexView rendered'
    
    # @$el.html(@template({ title: @title}) )
    # _.each @content, (item)->
    #   @$el.find('.widget-content').append(item)
    # , this
    # @

  initTokenInput: ->
    $('#image_tag_list').tokenInput '/manager/images/tags.json',
      prePopulate:       $("#image_tag_list").data("pre")
      preventDuplicates: true
      noResultsText:     "No results, needs to be created."
      animateDropdown:   false
      theme: 'facebook'

