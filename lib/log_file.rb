# frozen_string_literal: true

require_relative 'log_line'

module Lib
  # Class to read and store a log file
  class LogFile
    EXTENSION = '.log'

    attr_reader :invalid_lines

    def initialize(filename_path)
      @filename_path = filename_path
      @url_values = []
      @ip_values = []
      @visits_values = []
      @invalid_lines = []
    end

    def load
      read
      visits_values
    end

    private

    attr_reader :filename_path, :url_values, :ip_values, :visits_values

    def read
      File.open(filename_path).each do |line|
        log_line = LogLine.new(line)
        if log_line.valid?
          log_line.parse
        else
          invalid_lines << line
        end
      end
    end

    def parse(log_line)
      url, ip = log_line.parse

      url_values << [url]
      ip_values << [ip]
      visits_values << [url, ip]
    end
  end
end
