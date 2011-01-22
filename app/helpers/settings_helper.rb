require 'helpers/channel_factory'


module SettingsHelper

# TODO these should not be class or global variables!!!!
  
  $is_device_setup = false
  $channel = nil
  $theme = :controlpanel


# TODO There may be multiple devices/channels/messages

# TODO What happens when an existing device is reconnected? We probably should not
# create multiple channel objects



  def select_channel
    puts 'DEBUG: select_channel'
    channel_type = @params['channel']
    puts "DEBUG: #{channel_type} selected"
    $channel = ChannelFactory.new_instance(channel_type)
    $is_device_setup = true
    WebView.navigate Rho::RhoConfig.start_path
  end

  ## Select UI theme


  def select_theme
    puts 'DEBUG: select_theme'
    theme_type = @params['theme']
    puts "DEBUG: #{theme_type} selected"
    $theme = theme_type.to_sym
    WebView.navigate Rho::RhoConfig.start_path
  end
  
end
  

