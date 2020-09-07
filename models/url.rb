# frozen_string_literal: true

require_relative 'application_record'

module Models
  # Model to describe stored url
  class Url < ApplicationRecord
    has_many :visits
    has_many :ips, -> { distinct }, through: :visits

    scope :ordered_by_visits_count, -> { order(visits_count: :desc) }
    scope :ordered_by_ips_count, -> { order(ips_count: :desc) }

    def self.calculate
      urls_data = all.map { |url| [url.id, url.visits.count, url.ips.count] }

      import(%i[id visits_count ips_count], urls_data, on_duplicate_key_update: %i[visits_count ips_count])
    end

    def self.display
      views = ordered_by_visits_count.map(&:visits_display)
      uniq = ordered_by_ips_count.map(&:uniq_views_display)
      "#{views.join("\n")}\n#{uniq.join("\n")}"
    end

    def visits_display
      "#{id} #{visits_count} visits"
    end

    def uniq_views_display
      "#{id} #{ips_count} unique views"
    end
  end
end
