require 'json'

module AprilONeil
  class XCTool
    def initialize(input, formatter)
      @input     = input
      @formatter = formatter
      @events = {}
    end

    def start
      @formatter.before_start

      @input.each_line do |line|
        json  = JSON.parse(line)
        event_name   = json["event"]
        event_method = event_name.gsub("-", "_")

        @formatter.send(event_method, json)
      end

      @formatter.after_end
    end
  end
end
