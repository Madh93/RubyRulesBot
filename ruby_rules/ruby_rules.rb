require_relative 'utils'

module RubyRules
  class RubyRules

    attr_reader :response

    def initialize(msg)
      @msg = msg
    end

    def response
      @response = yield
    end

  end
end