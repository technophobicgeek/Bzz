require 'helpers/abstract_channel'

class AudioChannel < AbstractChannel

  
  def send_pulse
    # Play bzz file
    puts 'DEBUG: Playing bzz.wav'
    Alert.play_file '/public/alerts/bzz.wav'
  end
  
  def set_intensity(cmd)
    puts "DEBUG: AudioChannel.set_intensity #{cmd}"
    turn_off if (cmd == :off || cmd == 'off')
    play_sound cmd
  end
  
  def play_intensity(cmd, duration)
    puts 'DEBUG: AudioChannel.play_intensity'
    if (cmd == :off || cmd == 'off')
      puts "DEBUG: Off command, sleeping for #{duration}"
      sleep duration
    else
      puts "DEBUG: playing for #{duration}"
      play_sound cmd
      sleep duration.to_i
      Alert.stop
    end
  end
  
  def turn_off
    puts "DEBUG: about to stop audio"
    Alert.stop
  end
  
  private
  
    def play_sound(cmd)
      puts "DEBUG: Starting audio"
      filename = sound_file_map(cmd)
      Alert.set_max_volume
      Alert.play_file filename
      Alert.loop
    end

#     def play_sound(cmd)
#       puts "DEBUG: Starting audio"
#       filename = '/public/alerts/high_intensity_30s.mp3'
#       Alert.set_max_volume
#       Alert.play_file filename
#       Alert.loop
#     end

    def get_volume(cmd)
      puts 'DEBUG: Getting volume for ' + cmd
      vol = case cmd
        when :low,'low' then 25
        when :med,'med' then 50
        when :high,'high' then 100
      end
      vol
    end

    def sound_file_map(cmd)      
      puts 'DEBUG: Getting sound file name for ' + cmd
      sound_file = case cmd
        when :low,'low' then '/public/alerts/low_intensity_30s.mp3'
        when :med,'med' then '/public/alerts/med_intensity_30s.mp3'
        when :high,'high' then '/public/alerts/high_intensity_30s.mp3'
      end
      sound_file
    end	
  
end  # Class AudioChannel
