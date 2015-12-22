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

    def eval_sentences
      @sentences.each do |x| 
        x.gsub!("puts","p") if x.include?"puts"  # Puts && Eval -> :(
        x.gsub!("print","p") if x.include?"puts"  # Print && Eval -> :(
      end

      begin
        eval(@sentences.join(";"))
      rescue Exception => e
        e
      end
    end

  end
end