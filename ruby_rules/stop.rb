module RubyRules
  class Stop < RubyRules
   
    def initialize(msg)
      super(msg)
    end

    def response
      super { "Bye, #{@msg.from.first_name}" }
    end
  end
end