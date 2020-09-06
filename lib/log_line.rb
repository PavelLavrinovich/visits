# frozen_string_literal: true

module Lib
  # Class to validate and parse a log line
  class LogLine
    DELIMITER = ' '
    VALID_LINE_REGEXP = /\w+#{DELIMITER}\w+/.freeze

    def initialize(line_value)
      @line_value = line_value
    end

    def valid?
      line_value =~ VALID_LINE_REGEXP
    end

    def parse
      line_value.split(DELIMITER)
    end

    private

    attr_reader :line_value
  end
end
