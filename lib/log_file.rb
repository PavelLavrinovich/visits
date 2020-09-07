# frozen_string_literal: true

require_relative 'log_line'
require_relative 'parsed_data'
require_relative '../models/ip'
require_relative '../models/visit'
require_relative '../models/url'

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
      store
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

    def store
      ActiveRecord::Base.transaction do
        Models::Ip.import(%i[id], parsed_data.ip_values, on_duplicate_key_ignore: true)
        Models::Visit.import(%i[url_id ip_id], parsed_data.visit_values)
        Models::Url.import(%i[id], parsed_data.url_values, on_duplicate_key_ignore: true)
      end
    end

    def parsed_data
      @parsed_data ||= ParsedData.new
    end
  end
end
