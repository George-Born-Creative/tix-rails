class TixMgr.Views.ChartEditSeatView extends Backbone.View
  
  template: JST['manager/templates/chart_edit_seat']
  
  events: 
    'blur input[data-type="field"]': 'save'
    
  initialize: (data)->
    console.log "[SQUiiD] Initialized TixMgr.Views.ChartEditSeatView()"
    @model = new TixMgr.Models.Area(data.area)
    @data = data
    
  leave: ->
    console.log "[SQUiiD] Removing TixMgr.Views.ChartEditSeatView()"
    @unbind()
    @remove()
    
  render: ->
    console.log "[SQUiiD] Rendering TixMgr.Views.ChartEditSeatView()"
    @$el.html( @template( {area: @model.attributes } ))
    @
    
  save: ->
    self = this

    # TODO: Extrapolate this into a library pattern
    @$el.find('[data-type="field"]').each (i, field_el)->
      field_name = $(field_el).data('fieldname')
      field_val = $(field_el).val()
      console.log [field_name, field_val]
      self.model.set(field_name, field_val)
      self.data.area[field_name] = field_val

    console.log '[SQUiiD] Saving Area in TixMgr.Views.ChartEditSeatView()...'  
    console.log @model
    @model.save()
    console.log @model
    window.m = @model
    console.log '[SQUiiD] Saved Area in TixMgr.Views.ChartEditSeatView().'  
    