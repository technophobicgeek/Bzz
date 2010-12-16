require 'helpers/bluetooth_translator'

class TranslatorFactory
  def self.new_instance(translator_type)
    case translator_type
      when :bluetooth then
        BluetoothTranslator.new
      #when :audio then
      #  AudioTranslator.new
    end
  end

end # Class TranslatorFactory
