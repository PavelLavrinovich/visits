# frozen_string_literal: true

require 'spec_helper'
require_relative '../../models/url'

describe Models::Url do
  it { should have_many(:visits) }
end
