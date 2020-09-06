# frozen_string_literal: true

require_relative 'log_line'
require_relative 'parsed_data'

module Lib
  # Class to read and store a log file
  class LogFile
    EXTENSION = '.log'

    attr_reader :invalid_lines

    def initialize(filename_path)
      @filename_path = filename_path
      @invalid_lines = []
    end

    def load
      read
      parsed_data.visit_values
    end

    private

    attr_reader :filename_path

    def read
      File.open(filename_path).each do |line|
        log_line = LogLine.new(line)
        if log_line.valid?
          parsed_data.save(log_line.parse)
        else
          invalid_lines << line
        end
      end
    end

    def parsed_data
      @parsed_data ||= ParsedData.new
    end
  end
end
