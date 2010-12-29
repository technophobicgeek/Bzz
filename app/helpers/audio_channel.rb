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
    filename = sound_file_map(cmd)
    puts "DEBUG: identified file #{filename}"
    play_sound(filename)
    puts "DEBUG: main thread here"
  end
  
  def play_intensity(cmd, duration)
    puts 'DEBUG: AudioChannel.play_intensity'
    if (cmd == :off || cmd == 'off')
      puts "DEBUG: Off command, sleeping for #{duration}"
      sleep duration
      return
    else
      filename = sound_file_map(cmd)
      puts "DEBUG: playing file #{filename} for #{duration}"
      Alert.play_file filename 
      Alert.loop
      sleep duration.to_i
      Alert.stop
    end
  end
  
  def turn_off
    puts "DEBUG: about to stop audio"
    Alert.stop
  end
  
  private
  
    def play_sound(filename)     
      puts "DEBUG: Starting audio"
      Alert.play_file filename
      Alert.loop
    end
    
    def sound_file_map(cmd)      
      puts 'DEBUG: Getting sound file name for ' + cmd
      sound_file = case cmd
	when :low then '/public/alerts/low_intensity_30s.mp3'
	when :med then '/public/alerts/med_intensity_30s.mp3'
	when :high then '/public/alerts/high_intensity_30s.mp3'
	when 'low' then '/public/alerts/low_intensity_30s.mp3'
	when 'med' then '/public/alerts/med_intensity_30s.mp3'
	when 'high' then '/public/alerts/high_intensity_30s.mp3'
      end
      sound_file
    end	
  
end  # Class TestChannel
