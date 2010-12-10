# A module for creating patterns, translating them betn serialized form (in JSON?)

# TODO Needs an iterator so that internal representation can be encapsulated completely
# TODO Can we create a constructor that directly takes JSON?

require 'time'
require 'json'

module PatternHelper
  
  class Pattern
    
    def initialize
      @sequence = []
      @start_time = Time.now.to_i
    end
    
    def add(cmd)
      @sequence << {"Cmd" => cmd, "TS" => (Time.now.to_i - start_time) }
    end
    
    def serializeToJSON
      ::JSON.generate @sequence
    end
    
    # TODO Need validation here to check if it's a correct pattern
    def parseFromJSON(json_pattern)
      @sequence = Rho::JSON.parse
    end
    
    
    def validate
      true
    end
    
  end
  
end