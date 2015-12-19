module RubyRules
  class Error
    class << self

      def handle(e)
        error_hash = {
          code: e.error_code,
          info: get_error_info(e)
        }
        puts "#Error: #{error_hash}"
      end

      private

      def get_error_info(e)
        e.to_s.split("description: ").last[1..-3]
      end
    end
  end
end