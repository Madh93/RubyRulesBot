require 'telegram/bot'
require_relative 'ruby_rules/ruby_rules'
require_relative 'ruby_rules/start'
require_relative 'ruby_rules/stop'

TOKEN = 'TOKEN'
DEBUG = true

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    begin
      RubyRules::Debug.message_text(DEBUG,message)

      case RubyRules.get_command(message)
      when nil
      when '/start','/start@RubyRulesBot'
        cmd = RubyRules::Start.new(message)
        bot.api.send_message(chat_id: message.chat.id, text: cmd.response)
      when '/stop','/stop@RubyRulesBot'
        cmd = RubyRules::Stop.new(message)
        bot.api.send_message(chat_id: message.chat.id, text: cmd.response)
      when '/puts','/puts@RubyRulesBot'
        cmd = message.text.split(message.text.split[0]) # Separar mensaje
        eval_cmd = cmd.empty? ? "Syntax Error!" : "#{cmd.last}" # Obtener argumento
        eval_cmd.gsub!("puts","p") if eval_cmd.include? "puts"  # Puts && Eval -> :(
        puts "Eval: #{eval_cmd}"
        bot.api.send_message(chat_id: message.chat.id, text: "#{begin;eval(e = eval_cmd);rescue Exception => exc;"Syntax Error!";end}")
      end
    rescue Telegram::Bot::Exceptions::ResponseError => e
      RubyRules::Error.handle(e)  
    end    
  end
end