
# = Class BluetoothChannel
#   This class handles the sending and receiving of messages over a bluetooth
#    channel. The bluetooth device is assumed to be set up and paired by the OS.

## 
#  TODO
#    1. Error handling: what if there is no bluetooth device? What if the connection is dropped
#    2. Identity: make sure the device is the right kind before sending data from it

require 'rho/rhobluetooth'
require 'helpers/abstract_channel'
require 'helpers/bluetooth_translator'


class BluetoothChannel < AbstractChannel

  
# Maintain info about the connected device and last-played role
  @@connected_device_name = nil
  @@sender = false
  @@connection_status = "Disconnected"
  @@bluetooth_available = false
  @@translator = BluetoothTranslator.new
  @@message = nil

##
# Check if there is a bluetooth device already?
# What if there is not a device? Fail with reasonable error
# In case of known device, we need to associate a message translator.
# For now, bluetooth is probably hardcoded as a channel

  def initialize
    if Rho::BluetoothManager.is_bluetooth_available then
      Rho::BluetoothManager.set_device_name('Bluetooth Sender')
      @@bluetooth_available = true
    else
      Alert.show_popup('No bluetooth device paired')
    end
  end

##
# Send a message via bluetooth. The Bluetooth session must be started
# in server role for sending messages
  def set_intensity(cmd)
    @@sender = true
    @@message = @@translator.createMessage(cmd)
    if @@bluetooth_available then
      if @@connected_device_name == nil then
        Rho::BluetoothManager.create_session(Rho::BluetoothManager::ROLE_SERVER, 
                                             url_for( :action => :connection_callback))
      else
        write_message(@@message)
      end
    end
    render
  end
  
  def write_message(msg)
    puts "message to send: #{msg}"
    Rho::BluetoothSession.write(@@connected_device_name, msg)
  end

  def recv
  end

# Connection callback
# this callback performs a job after creating a session
# It has two parameters: status and device_name
# If we want to send data, that needs to happen if the status is OK

  def connection_callback 
    if @params['status'] == Rho::BluetoothManager::OK
       @@connected_device_name = @params['connected_device_name']
       @@connection_status = "Connected"
       puts "CONNECTED: " + @@connected_device_name  # for debugging
       Rho::BluetoothSession.set_callback(@@connected_device_name, url_for( :action => :session_callback))
       write_message(@@message) if @@sender
    end
  end 
 
# Session callback
# This is used to process events from the bluetooth device, whether it's data received (not applicable here)
# or errors or disconnects (TODO : need to handle those correctly)

  def session_callback
    puts "SESSION CALLBACK"
    event_type = @params['event_type']
    connected_device_name = @params['connected_device_name']
    if connected_device_name == @@connected_device_name
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
