require 'helpers/abstract_channel'
require 'helpers/bluetooth_translator'

class TestChannel < AbstractChannel

  @@translator = BluetoothTranslator.new

  def set_intensity(msg)
    puts 'DEBUG: TestChannel.set_intensity'
    @message = @@translator.createMessage(msg)
    puts "DEBUG: #{@message}"
  end

end  # Class TestChannel