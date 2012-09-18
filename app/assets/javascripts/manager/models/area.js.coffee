class TixMgr.Models.Area extends Backbone.Model
  urlRoot: '/manager/areas/'

  toJSON: ->
    json = this.attributes
    delete json['']
    
    delete json['dayof_price']
    delete json['presale_price']
    
    return json
