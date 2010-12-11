# A module for creating patterns, translating them betn serialized form (in JSON?)

# TODO Needs an iterator so that internal representation can be encapsulated completely
# TODO Can we create a constructor that directly takes JSON and Start_time?
# TODO Timeouts and other corner cases?

require 'time'
require 'json'

module PatternHelper
  
  class Pattern
    include Enumerable
    
       
    def initialize(cnt)
      puts 'DEBUG: new Pattern'
      @name = 'Pattern ' + cnt.to_s
      reset
    end

    def reset
      @sequence = []
      time_now = Time.now
      @create_ts = time_now.strftime('%m/%d/%y %I:%M %p')
      @start_time = time_now.to_i
    end
     
    # The start time is recorded as that of the first non-off command
    def add(cmd)
      time_now_i = Time.now.to_i     
      if @sequence.size == 0
        return if cmd == :off
        @start_time = time_now_i 
      end      
      ts = time_now_i - @start_time
      @sequence << {"CMD" => cmd, "TS" => ts }
      ts
    end
    
    def end_pattern(end_cmd)
      @duration = add(end_cmd)
    end
      
    
    def serializeToJSON
      ::JSON.generate @sequence
    end
    
    # TODO Need validation here to check if it's a correct pattern
    def parseFromJSON(json_pattern)
      @sequence = Rho::JSON.parse(json_pattern)
      @sequence
    end
        
    def validate
      true
    end
   
    def get_session_vars
      {
        'name' => @name,
        'sequence' => serializeToJSON,
        'create_ts' => @create_ts,
        'duration' => display_time(@duration)
      }
    end
    # method to make this an iterator
    def each
      i = 0
      until i == @sequence.size
        yield(@sequence[i])
        i += 1
      end
    end
    
    # Code adapted from stufftohelpyouout.blogspot.com

    def display_time(total_seconds)      
      days = total_seconds / 86400
      hours = (total_seconds / 3600) - (days * 24)
      minutes = (total_seconds / 60) - (hours * 60) - (days * 1440)
      seconds = total_seconds % 60
      
      display = ''
      display_concat = ''
      if days > 0
        display = display + display_concat + " #{days}d"
        display_concat = ' '
      end
      if hours > 0 || days > 0
        display = display + display_concat + " #{hours}h"
        display_concat = ' '
      end
      if days == 0 && (minutes > 0 || hours > 0)
        display = display + display_concat + " #{minutes}m"
        display_concat = ' '
      end
      if hours == 0 && days == 0 && minutes < 5
        display = display + display_concat + " #{seconds}s"
      end
      display
    end
        
  end
  
  class PlayPattern < Pattern

    def initialize(json_seq)
      puts 'DEBUG: new PlayPattern from sequence'
      puts json_seq
      @sequence = parseFromJSON(json_seq)
    end
    
    def add(cmd)
      # do nothing
    end
    
    def end_pattern(cmd)
      # do nothing
    end
    
    def reset
      # do nothing
    end
         
  end
  
end