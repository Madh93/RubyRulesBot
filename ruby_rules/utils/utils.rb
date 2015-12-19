module RubyRules
  module Utils

    def self.get_command(msg)
      msg.text.split[0] unless msg.text.nil?
    end

    def self.get_argument(msg)
      if !msg.text.nil?
        cmd = msg.text.split(get_command(msg))
        cmd.empty? ? "" : "#{cmd.last}"
      end
    end
    
  end
end