# A communication channel must implement 

# = Class BluetoothChannel
# 	This class handles the sending and receiving of messages over a bluetooth
#		channel. The bluetooth device is assumed to be set up and paired by the OS.

## 
#	TODO
#		1. Error handling: what if there is no bluetooth device? What if the connection is dropped
#		2. Identity: make sure the device is the right kind before sending data from it

require 'channel.rb'
require 'rho/rhobluetooth'

class BluetoothChannel < Channel

	attr_accessor :message
	
# Maintain info about the connected device and last-played role
  @@connected_device = nil
  @@sender = false
	@@connection_status = "Disconnected"

##
# Check if there is a bluetooth device already?
# What if there is not a device? Fail with reasonable error
# In case of known device, we need to associate a message translator.
# For now, bluetooth is probably hardcoded as a channel

	def initialize
    if Rho::BluetoothManager.is_bluetooth_available then
      Rho::BluetoothManager.set_device_name('Bluetooth Sender')
		end
	end

##
# Send a message via bluetooth. The Bluetooth session must be started
# in server role for sending messages
	def send(msg)
    @@sender = true
		@message = msg
    if Rho::BluetoothManager.is_bluetooth_available then
      Rho::BluetoothManager.create_session(Rho::BluetoothManager::ROLE_SERVER, url_for( :action => :connection_callback))
    end
    render
  end
  


	def recv
	end

# Connection callback
# The job of this callback is to perform a job after creating a session
# It has two parameters: status and device_name
# If we want to send data, that needs to happen if the status is OK

  def connection_callback 
    if @params['status'] == Rho::BluetoothManager::OK
	     @@connected_device = @params['connected_device_name']
			 @@connection_status = "Connected"
  	   puts "CONNECTED: " + @@connected_device	# for debugging
    	 Rho::BluetoothSession.set_callback(@@connected_device, url_for( :action => :session_callback))
     	if @@sender
      	puts "message to send: #{@message}"
       	Rho::BluetoothSession.write(@@connected_device, msg) 
     	end
    end
  end 
 
# Session callback
# This is used to process events from the bluetooth device, whether it's data received (not applicable here)
# or errors or disconnects (TODO : need to handle those correctly)

  def session_callback
    puts "SESSION CALLBACK"
		event_type = @params['event_type']
		connected_device = @params['connected_device_name']
    if connected_device == @@connected_device
    	unless @@sender
        if event_type == Rho::BluetoothSession::SESSION_INPUT_DATA_RECEIVED
        end
      end
			# If this is not the sender, we might still receive other events
      if event_type == Rho::BluetoothSession::SESSION_DISCONNECT
					Alert.show_popup("The device #{@@connected_device} has been disconnected.")
					@@connection_status = "Disconnected"
					@@connected_device = nil

					# TODO : Need to redirect user to the right page, maybe the setup device page?
      end
    end
  end

end  # Class BluetoothChannel
