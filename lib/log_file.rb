# frozen_string_literal: true

module Lib
  # Class to read and store a log file
  class LogFile
    EXTENSION = '.log'
    DELIMITER = ' '

    def initialize(filename_path)
      @filename_path = filename_path
      @url_values = []
      @ip_values = []
      @visits_values = []
    end

    def load
      read
      visits_values
    end

    private

    attr_reader :filename_path, :url_values, :ip_values, :visits_values

    def read
      File.open(filename_path).each do |line|
        url, ip = line.split(DELIMITER)
      
        url_values << [url]
        ip_values << [ip]
        visits_values << [url, ip]
      end
    end
  end
end
