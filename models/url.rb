# frozen_string_literal: true

require_relative 'application_record'

module Models
  # Model to describe stored url
  class Url < ApplicationRecord
    has_many :visits
  end
end
