require_relative 'utils'

module RubyRules
  class RubyRules

    BLACK_LIST = ["system","exec","`","%x[","IO.","File.","Dir.","Dir[","ENV"]

    def initialize(msg)
      @msg = msg
    end

    def response
      @response = "#{begin;yield;rescue Exception => e;e;end}"
    end

  end
end