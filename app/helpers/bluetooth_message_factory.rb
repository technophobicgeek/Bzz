##
# A factory to generate concrete messages for the bluetooth channel from
# abstract commands to the device

# TODO This should be a singleton, possibly
# TODO Should this be tied to the channel?

class BluetoothMessageFactory
	def initialize
		puts 'DEBUG: BluetoothMessageFactory'
	end
	def createMessage(abstract_msg)
		puts 'DEBUG: Creating Message for ' + abstract_msg
		bluetooth_msg = case abstract_msg
			when :off then [0]
			when :low then [10]
			when :med then [20]
			when :high then [30]
		end
		bluetooth_msg
	end
end
