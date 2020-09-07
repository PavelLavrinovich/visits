# frozen_string_literal: true

require_relative 'application_record'

module Models
  # Model to describe stored visits
  class Visit < ApplicationRecord
    belongs_to :ip
    belongs_to :url
  end
end
