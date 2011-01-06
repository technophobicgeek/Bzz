##
# A factory to generate concrete messages for the bluetooth channel from
# abstract commands to the device

# TODO This should be a singleton, possibly
# TODO Should this be tied to the channel?


class BluetoothTranslator
  def initialize
    puts 'DEBUG: BluetoothTranslator'
  end
  def createMessage(abstract_msg)
    puts 'DEBUG: Creating Message for ' + abstract_msg
    bluetooth_msg = case abstract_msg
      when :off,'off' then "0"
      when :low,'low' then "1"
      when :med,'med' then "2"
      when :high,'high' then "3"
    end
    bluetooth_msg
  end
end
