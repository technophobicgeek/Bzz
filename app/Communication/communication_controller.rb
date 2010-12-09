require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'helpers/channel_factory'
require 'helpers/bluetooth_message_factory'

class CommunicationController < Rho::RhoController
  include BrowserHelper

	$is_device_setup = false
	@@channel = nil
	@@msgfactory = nil

# The controller has member fields to store which channel it's using
# to communicate with the device and which message generator 
# is being used to translate abstract commands

#	TODO There may be multiple devices/channels/messages
##
# When the bluetooth channel is selected, the channel is set to be a bluetooth channel
# and the message factory is also set to be bluetooth

# TODO What happens when an existing device is reconnected? We probably should not
# create multiple channel objects

	def select_bluetooth_channel
		puts 'DEBUG: Bluetooth channel selected'
		select_channel(:bluetooth,BluetoothMessageFactory)
	end

	def select_audio_channel
	end

	def select_test_channel
		puts 'DEBUG: Test channel selected'
		select_channel(:test,BluetoothMessageFactory)
	end

	def select_channel(channel_type,msgfact)
		@@channel = ChannelFactory.new_instance(channel_type)
		@@msgfactory = msgfact.new
		$is_device_setup = true
		WebView.navigate Rho::RhoConfig.start_path
	end

##
# These following methods handle actual message-sending
# TODO simplify these methods using ruby cleverness (meta)

	def send_high_message
		send_message :high
	end

	def send_med_message
		send_message :med
	end

	def send_low_message
		send_message :low
	end

	def send_off_message
		send_message :off
	end

	def send_message(cmd)
		@@channel.send(@@msgfactory.createMessage(cmd))
		redirect :action => :session  # AJAX
	end

	# Head back to start page
	def end_session
		WebView.navigate Rho::RhoConfig.start_path
	end

end
