# = Class Channel
# 	This class is the abstract superclass for all communication channels, including
#			1. Bluetooth
#			2. Audio
#			3. HTTP/REST
#
# Possible bits of information it might store include
#		1. Status of last message
#		2. The actual last message

class Channel

	attr_accessor :message

##
# Send a message using this channel
	def send(msg)
	end

##
# Receive a message using this channel
	def recv
	end

end
