class TixMgr.Views.ChartEditPriceView extends Backbone.View
  
  template: JST['manager/templates/chart_edit_price']
  
  events: 
    'blur input[data-type="field"]': 'save'
    
  initialize: (data)->
    console.log "[SR] Initialized TixMgr.Views.ChartEditPriceView()"
    @model = new TixMgr.Models.Price(data.price)
    console.log ['model', @model]
    @data = data
    
  leave: ->
    console.log "[SR] Removing TixMgr.Views.ChartEditPriceView()"
    @unbind()
    @remove()
    
  render: ->
    console.log "[SR] Rendering TixMgr.Views.ChartEditPriceView()"
    @$el.html( @template( {price: @model.attributes, label: @data.label } ))
    @updateTotal()
    
    @
  
  updateTotal: ->
    console.log @model
    base = @model.get('base')
    service = @model.get('service')
    console.log [base, service]
    subtotal = parseFloat(base) + parseFloat(service)
    @$el.find('.total').text('$' + subtotal.toFixed(2))
  
  save: ->
    self = this

    # TODO: Extrapolate this into a library pattern
    @$el.find('[data-type="field"]').each (i, field_el)->
      field_name = $(field_el).data('fieldname')
      field_val = $(field_el).val()
      # console.log [field_name, field_val]
      self.model.set(field_name, field_val)
      self.data.price[field_name] = field_val
      
    console.log '[SR] Saving Price in TixMgr.Views.ChartEditPriceView()...'  
    
    
    @model.save {},
      success:  ->
        self.$el.effect('highlight')
        self.updateTotal()
        
          
    console.log '[SR] Saved Price in TixMgr.Views.ChartEditPriceView().'  
