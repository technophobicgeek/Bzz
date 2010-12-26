class AbstractChannel
  attr_accessor :message

  # Maintain two lists of messages: sent and received
  # along with timestamps

  def send(msg)
  end

  def recv
  end
  
  def send_pulse
  end
  
  def set_intensity
  end
  
  def play_intensity
  end

end # Class AbstractChannel
