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
      Lib::Filename.new(filename_path).validate

      log_file = Lib::LogFile.new(filename_path)
      log_file.load

      print_invalid_lines(log_file.invalid_lines) if log_file.invalid_lines.any?
    rescue ArgumentError => error
      puts error.message
    end

    private

    attr_reader :filename_path

    def print_invalid_lines(invalid_lines)
      puts 'Warning: Invalid lines'
      invalid_lines.each { |invalid_line| print invalid_line }
    end
  end
end

filename_path = ARGV.first
Bin::Stat.new(filename_path).display
