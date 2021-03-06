module RubyRules
  module Utils
    class Debug 

      class << self

        def message_text(debug, msg)
          if debug 
            msg_hash = {
              date: msg.date,
              user: msg.from.username,
              cmd: Utils.get_command(msg),
              arg: Utils.get_argument(msg)         
            }
            File.open("rubyrules.log", 'a') { |f| f.puts("#Message: #{msg_hash}") }
            puts "#Message: #{msg_hash}"
          end
        end

      end

    end    
  end
end