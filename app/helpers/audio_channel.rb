require 'helpers/abstract_channel'

class AudioChannel < AbstractChannel


  def send(msg)
    puts "DEBUG: #{msg}"
  end

  def send_pulse
  end
  
  def set_intensity
  end
  
end  # Class TestChannel
