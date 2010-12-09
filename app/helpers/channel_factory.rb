require 'helpers/test_channel'
require 'helpers/bluetooth_channel'

class ChannelFactory
	def self.new_instance(channel_type)
		case channel_type
			when :bluetooth then
				BluetoothChannel.new
			#when :audio then
			#	AudioChannel.new
			when :test then
				TestChannel.new
		end
	end

end # Class ChannelFactory
