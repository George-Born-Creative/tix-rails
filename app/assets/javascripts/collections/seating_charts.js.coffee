class Tix.Collections.SeatingCharts extends Backbone.Collection
  model: Tix.Models.SeatingChart
  
  
  comparator: ->
    #this.get('addedAt')