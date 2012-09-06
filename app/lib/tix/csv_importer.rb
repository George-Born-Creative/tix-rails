module Tix
  
  class CSVImporter
    
    def initialize(filename, model)
    
      require 'csv'

      CSV.foreach(filename, :headers => true,
                            :header_converters => :symbol ) do |row|
        begin
          model.create(row.to_hash)
        rescue ActiveRecord::RecordNotSaved # in current Rails
          # handle save failures here…
        end
      end
        
    end
  
    private
    
  end
  
end

