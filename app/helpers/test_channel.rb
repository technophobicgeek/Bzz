class TestChannel

	attr_accessor :message
	
	def send(msg)
		@message = msg
		puts "DEBUG: #{msg}"
  end
  


	def recv
	end

end  # Class TestChannel
