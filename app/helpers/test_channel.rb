require 'helpers/abstract_channel'

class TestChannel < AbstractChannel

	def send(msg)
		@message = msg
		puts "DEBUG: #{msg}"
  end
  


	def recv
	end
end  # Class TestChannel
