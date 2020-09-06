# frozen_string_literal: true

require_relative '../lib/filename'

module Bin
  class Stat
    def initialize(filename_path)
      @filename_path = filename_path
    end

    def display
      Lib::Filename.new(filename_path).validate
    rescue ArgumentError => e
      puts e.message
    end

    private

    attr_reader :filename_path
  end
end

filename_path = ARGV.first
Bin::Stat.new(filename_path).display
