require_relative 'utils'

module RubyRules
  class Debug 
    class << self

      def message_text(debug, msg)
        if debug 
          msg_hash = {
            user: msg.from.username,
            cmd: ::RubyRules.get_command(msg),
            arg: ::RubyRules.get_argument(msg)         
          }
          puts "#Message.Text: #{msg_hash}"
        end
      end

    end    
  end
end