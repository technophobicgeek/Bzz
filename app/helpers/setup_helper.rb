##
# This module controls the vibe setup screen
# This is used to set up both the actual device
# as well as the communication channels e.g.
# bluetooth, audio etc.

module SetupHelper

	def selectchannel
		render :action => :selectchannel
	end

end
