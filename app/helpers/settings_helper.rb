require 'helpers/channel_factory'


module SettingsHelper

# TODO these should not be class or global variables!!!!
  
  $is_device_setup = false
  $channel = nil
  $theme = :controlpanel

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
    $channel = ChannelFactory.new_instance(channel_type)
    $is_device_setup = true
    WebView.navigate Rho::RhoConfig.start_path
  end

  ## Select UI theme
  def select_controlpanel
    puts 'DEBUG: controlpanel selected'
    select_theme(:controlpanel)
  end

  def select_reversecontrolpanel
    puts 'DEBUG: reversecontrolpanel selected'
    select_theme(:reversecontrolpanel)
  end

  def select_theme(theme_type)
    puts "DEBUG: #{theme_type} selected"
    $theme = theme_type
    WebView.navigate Rho::RhoConfig.start_path
  end
  
end
  

