# frozen_string_literal: true

require_relative '../db/schema'

module Models
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
