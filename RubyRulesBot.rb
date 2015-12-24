require 'telegram/bot'
require_relative 'ruby_rules'

DEBUG = true

Telegram::Bot::Client.run(File.readlines("TOKEN").join) do |bot|
  bot.listen do |message|
    begin
      case RubyRules::Utils.get_command(message)
      when nil
      when '/start','/start@RubyRulesBot'
        cmd = RubyRules::Start.new(message)
        bot.api.send_message(chat_id: message.chat.id, text: cmd.response)
      when '/stop','/stop@RubyRulesBot'
        cmd = RubyRules::Stop.new(message)
        bot.api.send_message(chat_id: message.chat.id, text: cmd.response)
      when '/puts','/puts@RubyRulesBot'
        RubyRules::Utils::Debug.message_text(DEBUG,message)
        cmd = RubyRules::Puts.new(message)
        bot.api.send_message(chat_id: message.chat.id, text: cmd.response)
      end
    rescue Telegram::Bot::Exceptions::ResponseError => e
      RubyRules::Utils::Error.handle(e)  
    end    
  end
end