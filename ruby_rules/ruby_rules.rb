require_relative 'error'
require_relative 'debug'
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