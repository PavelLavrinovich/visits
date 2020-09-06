# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/log_line'

RSpec.describe Lib::LogLine do
  let(:log_line) { described_class.new('/help_page/1 126.318.035.038') }

  describe '#valid?' do
    it 'returns true' do
      expect(log_line).to be_valid
    end

    context 'with invalid line' do
      let(:log_line) { described_class.new('invalid_line') }

      it 'returns false' do
        expect(log_line).not_to be_valid
      end
    end
  end

  describe '#parse' do
    it 'returns parsed line' do
      expect(log_line.parse).to eq(['/help_page/1', '126.318.035.038'])
    end
  end
end
