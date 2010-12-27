class AbstractChannel
  attr_accessor :message

  ## Send a single pulse of length 0.4
  # TODO not hardcode the duration of pulse
  
  def send_pulse
    puts 'DEBUG: send_pulse'
    set_intensity :high
    sleep 0.4
    set_intensity :off
  end
  
  def set_intensity(cmd)
  end
  
  def play_intensity(cmd,dur)
    set_intensity cmd
    sleep dur
  end

  def turn_off
    set_intensity :off
  end
  
end # Class AbstractChannel
