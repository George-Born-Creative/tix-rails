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
    $c = $('.chart-section-colorpicker').colorpicker()
    if $c.size() > 0 && @cp_initialized != true
      @initColorPicker()
      @cp_initialized = true

  initColorPicker: ->
    self = this
    $('.chart-section-colorpicker').colorpicker()
      .off()
      .on 'changeColor', (ev)->
        TixLib.Dispatcher.trigger('sectionColorChange', {color: ev.color.toHex(), section: self.model.attributes })
      .on 'show', (ev)->
        return
      .on 'hide', @onColorSelect
      
  onColorSelect: (ev)->
    @model.save( {color: ev.color.toHex()} )
    console.log "[SR] Called save for section"
  