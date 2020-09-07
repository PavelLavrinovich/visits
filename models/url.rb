# frozen_string_literal: true

require_relative 'application_record'

module Models
  # Model to describe stored url
  class Url < ApplicationRecord
    has_many :visits
    has_many :ips, -> { distinct }, through: :visits

    def self.calculate
      urls_data = all.map { |url| [url.id, url.visits.count, url.ips.count] }

      import(%i[id visits_count ips_count], urls_data, on_duplicate_key_update: %i[visits_count ips_count])
    end
  end
end
