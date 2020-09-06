# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/log_file'

RSpec.describe Lib::LogFile do
  describe '#load' do
    let(:log_file) { Lib::LogFile.new('spec/fixtures/webserver_small.log') }
    let(:expected_visits_data) do
      [
        ['/help_page/1', '126.318.035.038'],
        ['/contact', '184.123.665.067'],
        ['/home', '184.123.665.067'],
        ['/about/2', '444.701.448.104'],
        ['/help_page/1', '929.398.951.889'],
        ['/index', '444.701.448.104'],
        ['/help_page/1', '722.247.931.582'],
        ['/about', '061.945.150.735'],
        ['/help_page/1', '646.865.545.408'],
        ['/home', '235.313.352.950'],
      ]
    end

    it 'reads file with data' do
      expect(log_file.load).to eq(expected_visits_data)
    end

    it 'stores the line'

    context 'with invalid line' do
      it 'adds the line to invalid group'

      it 'does not store the line'
    end
  end
end
