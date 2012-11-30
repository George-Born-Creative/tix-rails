class TixMgr.Views.ChartEditSectionView extends Backbone.View
  
  template: JST['manager/templates/chart_edit_section']
  
  events:
    'blur input[data-type="field"]': 'save'
    'hover .chart-section-colorpicker': 'initColorPickerIfExists'
  
  initialize: (data)->
    console.log "[SR] Initialized TixMgr.Views.ChartEditSectionView()"
    @model = new TixMgr.Models.Section(data.section)
    
    _.bindAll this, 'onColorSelect'
  render: ->
    console.log "[SR] Rendering TixMgr.Views.ChartEditSectionView()"
    @$el.html( @template({section: @model.attributes }) )
    @initColorPicker()
    @
    
  save: ->
    self = this
    
    # TODO: Extrapolate this into a library pattern
    @$el.find('[data-type="field"]').each (i, field_el)->
      field_name = $(field_el).data('fieldname')
      field_val = $(field_el).val()
      self.model.set(field_name, field_val)
    
    console.log '[SR] Saving section in TixMgr.Views.ChartEditSectionView()...'  
    
    @model.save()
      #success:  $(field_el).effect('highlight');
      
  leave: ->
    console.log '[SR] Saved section in TixMgr.Views.ChartEditSectionView().'
    @unbind()
    @remove()
    

  initColorPickerIfExists: ->
    console.log '[SR] initColorPicker() in TixMgr.Views.ChartEditSectionView().'
    $c = $('.chart-section-colorpicker')
    
    if $c.size() > 0 && @cp_initialized != true
      @initColorPicker()
      @cp_initialized = true

  initColorPicker: ->
    self = this
    $c = $('.chart-section-colorpicker')
    $input = $c.find('input[type="text"]')
    
    $input.miniColors({
      change: (hex, rgb)->
        TixLib.Dispatcher.trigger('sectionColorChange', {color: hex, section: self.model.attributes })
    })
    
    $input.on 'blur', ->
      self.onColorSelect({hex:  $(this).val()} ) # trigger the ajax save
    
  onColorSelect: (data)->
    self = this
    @model.set('color',  data.hex )
    
    @model.save {},
      success:  ->
        $('.chart-section-colorpicker').parent().parent().effect('highlight')
    
  