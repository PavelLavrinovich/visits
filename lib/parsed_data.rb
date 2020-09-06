# frozen_string_literal: true

module Lib
  # Class to save parsed data
  class ParsedData
    attr_reader :url_values, :ip_values, :visit_values

    def initialize
      @url_values = []
      @ip_values = []
      @visit_values = []
    end

    def save(parsed_line)
      url, ip = parsed_line

      url_values << [url]
      ip_values << [ip]
      visit_values << [url, ip]
    end
  end
end
