# frozen_string_literal: true

require 'pry'
require_relative '../lib/filename'
require_relative '../lib/log_file'

module Bin
  # Main class to display stat
  class Stat
    def initialize(filename_path)
      @filename_path = filename_path
    end

    def display
      validate_and_read_data
    rescue ArgumentError => error
      puts error.message
    end

    private

    attr_reader :filename_path

    def validate_and_read_data
      Lib::Filename.new(filename_path).validate

      log_file = Lib::LogFile.new(filename_path)
      log_file.load

      print_invalid_lines(log_file.invalid_lines)
    end

    def print_invalid_lines(invalid_lines)
      return if invalid_lines.empty?

      puts 'Warning: Invalid lines'
      invalid_lines.each { |invalid_line| print invalid_line }
    end
  end
end

filename_path = ARGV.first
Bin::Stat.new(filename_path).display
