class TixMgr.Models.Chart extends Backbone.Model
  urlRoot: '/manager/charts/'

  toJSON: ->
    json = this.attributes
    delete json['']
    
    delete json['sections']
    
    return json
