module RubyRules
  class Start < RubyRules
   
    def initialize(msg)
      super(msg)
      response
    end

    def response
      super { "Hello, #{@msg.from.first_name}" }
    end
  end
end