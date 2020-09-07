# frozen_string_literal: true

module Models
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
