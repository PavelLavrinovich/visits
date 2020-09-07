# frozen_string_literal: true

require 'spec_helper'
require_relative '../../models/visit'

describe Models::Visit do
  it { should belongs_to(:ip) }
  it { should belongs_to(:url) }
end
