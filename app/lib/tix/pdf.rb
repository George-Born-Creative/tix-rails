require 'prawn'
module Tix
  class PDF
    
    def generate_ticket
      
      doc = Prawn::Document.generate("hello.pdf") do
        text "Hello World!"
      end
      
      
      
      
    end
    
  end
end