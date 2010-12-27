require 'helpers/abstract_channel'

class AudioChannel < AbstractChannel

  @@audiothread = nil
  
  def send_pulse
    # Play bzz file
    puts 'DEBUG: Playing bzz.wav'
    Alert.play_file '/public/alerts/bzz.wav','audio/x-wav' 
  end
  
  def set_intensity(cmd)
    puts "DEBUG: AudioChannel.set_intensity #{cmd}"
    return if (cmd == :off || cmd == 'off')
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
      duration.to_i.times do
	Alert.play_file filename,'audio/x-wav' 
      end
    end
  end
  
  def turn_off
    puts "DEBUG: about to kill thread #{@@audiothread}"
    @@audiothread.exit if @@audiothread # kill current thread
    @@audiothread = nil
  end
  
  private
  
    def play_sound(filename)
      puts "DEBUG: about to kill thread #{@@audiothread}"
      @@audiothread.exit if @@audiothread # kill current thread
      @@audiothread = Thread.new(filename) do |f|
	puts "DEBUG: Starting new thread for #{f}"
	loop {Alert.play_file f,'audio/x-wav'}
      end
      puts "DEBUG: started thread #{@@audiothread}"
    end
    
    def sound_file_map(cmd)      
      puts 'DEBUG: Getting sound file name for ' + cmd
      sound_file = case cmd
	when :low then '/public/alerts/low_intensity_1s.wav'
	when :med then '/public/alerts/med_intensity_1s.wav'
	when :high then '/public/alerts/high_intensity_1s.wav'
	when 'low' then '/public/alerts/low_intensity_1s.wav'
	when 'med' then '/public/alerts/med_intensity_1s.wav'
	when 'high' then '/public/alerts/high_intensity_1s.wav'
      end
      sound_file
    end	
  
end  # Class TestChannel
