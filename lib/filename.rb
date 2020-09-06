# frozen_string_literal: true

module Lib
  # Class to validate a filename
  class Filename
    EXTENSION = '.log'

    def initialize(filename_path)
      @filename_path = filename_path
    end

    def validate
      raise ArgumentError, 'Please provide file' unless filename_path
      raise ArgumentError, 'Path to the log file is missing' unless File.directory?(File.dirname(filename_path))
      raise ArgumentError, 'File extenstion is invalid' if File.extname(filename_path) != EXTENSION
      raise ArgumentError, 'Log file is missing' unless File.file?(filename_path)

      true
    end

    private

    attr_reader :filename_path
  end
end
