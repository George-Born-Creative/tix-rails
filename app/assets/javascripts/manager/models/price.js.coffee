class TixMgr.Models.Price extends Backbone.Model
  urlRoot: '/manager/prices/'

  toJSON: ->
    json = this.attributes
    delete json['']
      
    return json
