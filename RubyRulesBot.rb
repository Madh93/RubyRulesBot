require 'telegram/bot'

token = 'TOKEN'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text.split[0]
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    when '/puts','/puts@RubyRulesBot'
      puts message.text
      cmd = message.text.split(message.text.split[0])
      eval_cmd = cmd.empty? ? "Syntax Error!" : "#{cmd.last}"
      bot.api.send_message(chat_id: message.chat.id, text: "#{begin;eval(e = eval_cmd);rescue Exception => exc;"Syntax Error!";end}")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "I don't understand you :(")
    end
  end
end