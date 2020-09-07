# frozen_string_literal: true

require 'spec_helper'
require_relative '../../models/ip'

describe Models::Ip do
  it { should have_many(:visits) }
end
