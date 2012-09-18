class TixMgr.Models.Section extends Backbone.Model
  urlRoot: '/manager/sections/'

  # Remove areas before saving since areas are saved atomically on their own
  toJSON: ->
    json = this.attributes
    delete json['']
    
    delete json['areas']
    return json
