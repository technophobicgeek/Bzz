require 'helpers/abstract_channel'
require 'helpers/bluetooth_translator'

class TestChannel < AbstractChannel

  @@translator = BluetoothTranslator.new

  def send(msg)
    @message = @@translator.createMessage(msg)
    puts "DEBUG: #{@message}"
  end
  

  def send_pulse
    puts 'DEBUG: send_pulse'
    send :high
    sleep 0.4
    send :off
  end
  
  def set_intensity
  end

  def play_intensity
  end
  
end  # Class TestChannel