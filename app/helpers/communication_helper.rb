require 'helpers/channel_factory'
require 'helpers/translator_factory'

module CommunicationHelper

  # TODO these should not be class or global variables!!!!
  
  $is_device_setup = false
  @@channel = nil
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
    select_channel(:bluetooth) 
  end

  def select_audio_channel
    puts 'DEBUG: Audio channel selected'
    select_channel(:audio)
  end

  def select_test_channel
    puts 'DEBUG: Test channel selected'
    select_channel(:test)
  end

  def select_channel(channel_type)
    @@channel = ChannelFactory.new_instance(channel_type)
    $is_device_setup = true
    WebView.navigate Rho::RhoConfig.start_path
  end

  
  ##
  # These following methods handle actual message-sending

  def callback
    #WebView.execute_js('dummyFunction();');
    puts 'callback: needs to execute script to change button color'
  end


  def send_pulse
    @@channel.send_pulse
  end
  
  def set_intensity
    cmd = @params['cmd']
    puts 'DEBUG: set_intensity'
    puts cmd
    channel_send cmd
    @@pattern.add cmd if @@pattern
    redirect :action => :callback
  end


  ##
  # For each item in the pattern, play command for duration
  def play_pattern(pattern)
    pattern.each do |p|
      channel_send(p['CMD'])
      t = p['DUR']
      sleep (t)
    end
  end

  private
    def channel_send(msg)
      @@channel.send(msg) if @@channel # else raise exception?
    end
end
