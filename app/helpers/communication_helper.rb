require 'helpers/channel_factory'
require 'helpers/bluetooth_message_factory'

module CommunicationHelper

  # TODO these should not be class or global variables!!!!
  
  $is_device_setup = false
  @@channel = nil
  @@msgfactory = nil
  @@pattern = nil

# The controller has member fields to store which channel it's using
# to communicate with the device and which message generator 
# is being used to translate abstract commands

#  TODO There may be multiple devices/channels/messages
##
# When the bluetooth channel is selected, the channel is set to be a bluetooth channel
# and the message factory is also set to be bluetooth

# TODO What happens when an existing device is reconnected? We probably should not
# create multiple channel objects

  def select_bluetooth_channel
    puts 'DEBUG: Bluetooth channel selected'
    select_channel(:bluetooth,BluetoothMessageFactory) # TODO need abstract class here
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

  def callback
    #WebView.execute_js('dummyFunction();');
    puts 'callback: needs to execute script to change button color'
  end
  
  def send_message
    cmd = @params['cmd']
    puts 'DEBUG: send_message'
    puts cmd
    @@channel.send(@@msgfactory.createMessage(cmd))
    @@pattern.add cmd if @@pattern
    redirect :action => :callback
  end
  
  ##
  # For each item in the pattern
  def play_pattern(pattern)
    t = 0 # start
    pattern.each do |p|
      tnew = p['TS']
      sleep (tnew - t)
      send_message(p['CMD'])
      t = tnew
    end
  end

end
