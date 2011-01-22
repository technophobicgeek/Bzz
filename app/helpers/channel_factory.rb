require 'helpers/test_channel'
require 'helpers/bluetooth_channel'
require 'helpers/audio_channel'

class ChannelFactory
  def self.new_instance(channel_type)
    case channel_type
      when :bluetooth,'bluetooth' then
        BluetoothChannel.new
      when :audio,'audio' then
        AudioChannel.new
      when :test,'test' then
        TestChannel.new
    end
  end

end # Class ChannelFactory
