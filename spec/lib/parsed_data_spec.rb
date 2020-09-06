# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/parsed_data'

RSpec.describe Lib::ParsedData do
  let(:parsed_data) { described_class.new }

  describe '#save' do
    let(:expected_visit_values) do
      [
        ['/help_page/1', '126.318.035.038'],
        ['/help_page/2', '1.3.0.8']
      ]
    end

    before do
      parsed_data.save(['/help_page/1', '126.318.035.038'])
      parsed_data.save(['/help_page/2', '1.3.0.8'])
    end

    it 'saves ip values' do
      expect(parsed_data.ip_values).to eq([['126.318.035.038'], ['1.3.0.8']])
    end

    it 'saves url values' do
      expect(parsed_data.url_values).to eq([['/help_page/1'], ['/help_page/2']])
    end

    it 'saves visit values' do
      expect(parsed_data.visit_values).to eq(expected_visit_values)
    end
  end
end
