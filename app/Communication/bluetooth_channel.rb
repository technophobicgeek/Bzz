# = Class BluetoothChannel
# 	This class handles the sending and receiving of messages over a bluetooth
#		channel. The bluetooth device is assumed to be set up and paired by the OS.

## 
#	TODO
#		1. Error handling: what if there is no bluetooth device? What if the connection is dropped
#		2. Identity: make sure the device is the right kind before sending data from it
:browse confirm wa

require 'channel.rb'
require 'rho/rhobluetooth'

class BluetoothChannel < Channel
	
# Maintain info about the connected device and last-played role
  @@connected_device = ""
  @@sender = false

##
# Check if there is a bluetooth device already?
# What if there is not a device? Fail with reasonable error

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
    if Rho::BluetoothManager.is_bluetooth_available then
      Rho::BluetoothManager.create_session(Rho::BluetoothManager::ROLE_SERVER, url_for( :action => :connection_callback))
    end
    render
  end
  

	end

	def recv
	end

# Connection callback
 
  def connection_callback 
    if @params['status'] == Rho::BluetoothManager::OK
	     @@connected_device = @params['connected_device_name']
  	   puts "CONNECTED: " + @@connected_device	# for debugging
    	 Rho::BluetoothSession.set_callback(@@connected_device, url_for( :action => :session_callback))
     	if @@sender
      	puts "message to send: #{@message}"
       	Rho::BluetoothSession.write(@@connected_device, msg) 
     	end
    end
  end 
 
# Session callback
# In the current version, since we're not receiving any data, this shouldn't actually do anything

  def session_callback
    puts "SESSION CALLBACK"
    unless @@sender
      if @params['connected_device_name'] == @@connected_device
        if @params['event_type'] == Rho::BluetoothSession::SESSION_INPUT_DATA_RECEIVED
          puts "DATA RECEIVE"
          while Rho::BluetoothSession.get_status(@@connected_device) > 0
            str = Rho::BluetoothSession.read_string(@@connected_device)
            puts "GOT STRING: #{str}"
            e = Marshal.load(Rho::RhoSupport.url_decode(str))
          end
        end
      end
    end
  end

end
