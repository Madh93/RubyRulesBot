module RubyRules
  class Start < RubyRules
   
    def initialize(msg)
      super(msg)
    end

    def response
      super { "Hello, #{@msg.from.first_name}" }
    end
  end
end