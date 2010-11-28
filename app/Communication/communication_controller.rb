require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'helpers/session_helper'
require 'helpers/bluetooth_channel'
require 'helpers/test_channel'
require 'helpers/bluetooth_message_factory'

class CommunicationController < Rho::RhoController
  include BrowserHelper
	include SessionHelper


	@@channel = nil
	@@msgfactory = nil

# The controller has member fields to store which channel it's using
# to communicate with the device and which message generator 
# is being used to translate abstract commands

#	TODO There may be multiple devices/channels/messages

	def select_channel
		puts 'DEBUG: Selecting channel'
		render :action => :selectchannel
	end

##
# When the bluetooth channel is selected, the channel is set to be a bluetooth channel
# and the message factory is also set to be bluetooth

# TODO What happens when an existing device is reconnected? We probably should not
# create multiple channel objects

	def select_bluetooth_channel
		puts 'DEBUG: Bluetooth channel selected'
		@@channel = BluetoothChannel.new
		@@msgfactory = BluetoothMessageFactory.new
	end

	def select_audio_channel
	end

	def select_test_channel
		puts 'DEBUG: Test channel selected'
		@@channel = TestChannel.new
		@@msgfactory = BluetoothMessageFactory.new
		puts @@channel
		puts @@msgfactory
		render :action => :index, :back => '/app/' 
	end


##
# These following methods handle actual message-sending
# TODO simplify these methods using ruby cleverness (meta)

def send_high_message
	msg = @@msgfactory.createMessage(:high)
	@@channel.send(@@msgfactory.createMessage(:high))
	redirect :action => :session
end

def send_med_message
	@@channel.send(@@msgfactory.createMessage(:med))
	render :action => :session
end

def send_low_message
	@@channel.send(@@msgfactory.createMessage(:low))
end

def send_off_message
	@@channel.send(@@msgfactory.createMessage(:off))
	render :action => :session
end


end
