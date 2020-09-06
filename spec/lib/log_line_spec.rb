# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/log_line'

RSpec.describe Lib::LogLine do
  let(:log_line) { Lib::LogLine.new('/help_page/1 126.318.035.038') }

  describe '#valid?' do
    it 'returns true' do
      expect(log_line.valid?).to be_truthy
    end

    context 'with invalid line' do
      let(:log_line) { Lib::LogLine.new('invalid_line') }

      it 'returns false' do
        expect(log_line.valid?).to be_falsey
      end
    end
  end

  describe '#parse' do
    it 'returns parsed line' do
      expect(log_line.parse).to eq(['/help_page/1', '126.318.035.038'])
    end
  end
end
