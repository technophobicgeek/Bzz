# A module for creating patterns, translating them betn serialized form (in JSON?)

# TODO Needs an iterator so that internal representation can be encapsulated completely
# TODO Can we create a constructor that directly takes JSON and Start_time?
# TODO Timeouts and other corner cases?

require 'time'
require 'json'

module PatternHelper
  
  class Pattern
    include Enumerable
    
    def initialize
      puts 'DEBUG: new Pattern'
      reset
    end
    
    def add(cmd)
      @sequence << {"Cmd" => cmd, "TS" => (Time.now.to_i - @start_time) }
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
    
    def reset
      @sequence = []
      @start_time = Time.now.to_i
    end
    
    # method to make this an iterator
    def each
      i = 0
      until i == @sequence.size
        yield(@sequence[i])
        i += 1
      end
    end
    
    
  end
  
end