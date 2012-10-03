class Tix.Collections.Artists extends Backbone.Collection

  model: Tix.Models.Artist
  
  url: '/api/artists/'
  
  comparator: (artist)->
    name = artist.get('name')
    name = name.toLowerCase()
    name = name.split("")
    name = _.map name, (letter)->
      code = letter.charCodeAt(0) 
      code += 59 if code == 64 # put @ at end
      return String.fromCharCode( code )
      
    return name