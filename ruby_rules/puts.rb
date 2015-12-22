require_relative 'utils'

module RubyRules
  class Puts < RubyRules
   
    def initialize(msg)
      super(msg)
      @sentences = get_sentences
    end

    def response
      response = eval_sentences
      super { "#{response.nil? ? "nil" : response}" }
    end

    private

    def get_sentences
      if BLACK_LIST.any? { |word| @msg.text.include?(word) }
        ["false"]
      else
        Utils.get_argument(@msg).split(";")
      end
    end

    def add_capture_stdout(str_out)
      @sentences.insert(str_out-1,"sTr_OuT=''")
      value = @sentences[str_out] 
      ["puts ","print "].each do |p|
        value.gsub!(p,"sTr_OuT += Utils.capture_stdout { p ") if value.include? p
      end
      @sentences[str_out] = value << "}"
      @sentences.insert(str_out+1,"p sTr_OuT")
    end

    def eval_sentences

      str_out = 0

      # Find last console output
      @sentences.each_with_index do |sentence,i| 
        ["puts ","print "].each do |p|
          str_out = i+1 if sentence.include? p
        end
      end

      # Allow to show output
      if str_out > 0
        add_capture_stdout(str_out)
      end

      begin
        eval(@sentences.join(";"))
      rescue Exception => e
        e
      end
    end

  end
end