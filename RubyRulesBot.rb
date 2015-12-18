require 'telegram/bot'

token = 'TOKEN'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts message.text
    command = message.text.split[0] unless message.text.nil?
    case command
    when nil
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    when '/puts','/puts@RubyRulesBot'
      cmd = message.text.split(message.text.split[0]) # Separar mensaje
      eval_cmd = cmd.empty? ? "Syntax Error!" : "#{cmd.last}" # Obtener argumento
      eval_cmd.gsub!("puts","p") if eval_cmd.include? "puts"  # Puts && Eval -> :(
      puts "Eval: #{eval_cmd}"
      bot.api.send_message(chat_id: message.chat.id, text: "#{begin;eval(e = eval_cmd);rescue Exception => exc;"Syntax Error!";end}")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "I don't understand you :(")
    end
  end
end