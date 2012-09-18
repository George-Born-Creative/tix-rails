class TixMgr.Views.ChartEditPriceView extends Backbone.View
  
  template: JST['manager/templates/chart_edit_price']
  
  events: 
    'blur input[data-type="field"]': 'save'
    
  initialize: (data)->
    console.log "[SQUiiD] Initialized TixMgr.Views.ChartEditPriceView()"
    @model = new TixMgr.Models.Price(data.price)
    console.log ['model', @model]
    @data = data
    
  leave: ->
    console.log "[SQUiiD] Removing TixMgr.Views.ChartEditPriceView()"
    @unbind()
    @remove()
    
  render: ->
    console.log "[SQUiiD] Rendering TixMgr.Views.ChartEditPriceView()"
    @$el.html( @template( {price: @model.attributes, label: @data.label } ))
    @
    
  save: ->
    self = this

    # TODO: Extrapolate this into a library pattern
    @$el.find('[data-type="field"]').each (i, field_el)->
      field_name = $(field_el).data('fieldname')
      field_val = $(field_el).val()
      console.log [field_name, field_val]
      self.model.set(field_name, field_val)
      self.data.price[field_name] = field_val

    console.log '[SQUiiD] Saving Price in TixMgr.Views.ChartEditPriceView()...'  

    @model.save()
    
    console.log '[SQUiiD] Saved Price in TixMgr.Views.ChartEditPriceView().'  
