require 'helpers/channel_factory'

module CommunicationHelper

  # TODO these should not be class or global variables!!!!
  
  @@pattern = nil

 
  ##
  # These following methods handle actual message-sending

  def callback
    #WebView.execute_js('dummyFunction();');
    puts 'callback: needs to execute script to change button color'
  end

  def turn_off
    $channel.turn_off if $channel
  end
  

  def send_pulse
    $channel.send_pulse if $channel
  end
  
  def set_intensity
    cmd = @params['cmd']
    puts 'DEBUG: set_intensity'
    puts cmd
    $channel.set_intensity cmd
    puts "DEBUG: done setting intensity for #{$channel}"
    @@pattern.add cmd if @@pattern
    redirect :action => :callback
  end


  ##
  # For each item in the pattern, play command for duration
  def play_pattern(pattern)
    pattern.each do |p|
      $channel.play_intensity(p['CMD'],p['DUR'])
    end
    $channel.turn_off
  end


end
