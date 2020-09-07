# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/log_line'

RSpec.describe Lib::LogLine do
  let(:log_line_value) { '/help_page/1 126.318.035.038' }

  describe '#valid?' do
    subject(:log_line) { described_class.new(log_line_value) }

    context 'with valid line' do
      it { is_expected.to be_valid }
    end

    context 'with invalid line' do
      let(:log_line_value) { 'invalid_line' }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#parse' do
    subject(:parsed_log_line) { described_class.new(log_line_value).parse }

    it { is_expected.to eq(['/help_page/1', '126.318.035.038']) }
  end
end
