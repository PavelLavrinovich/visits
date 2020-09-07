# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/log_file'

RSpec.describe Lib::LogFile do
  describe '#load' do
    subject(:load) { log_file.load }

    let(:log_file) { described_class.new('spec/fixtures/webserver_small.log') }
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
        ['/home', '235.313.352.950']
      ]
    end
    let(:total_lines) { 10 }

    it { is_expected.to eq(expected_visits_data) }

    it { expect { load }.to change { Models::Ip.count }.by(total_lines) }
    it { expect { load }.to change { Models::Url.count }.by(total_lines) }
    it { expect { load }.to change { Models::Visit.count }.by(total_lines) }

    context 'with invalid line' do
      let(:log_file) { described_class.new('spec/fixtures/webserver_small_with_invalid.log') }
      let(:expected_visits_data) do
        [
          ['/help_page/1', '126.318.035.038'],
          ['/contact', '184.123.665.067'],
          ['/about/2', '444.701.448.104'],
          ['/help_page/1', '929.398.951.889'],
          ['/index', '444.701.448.104'],
          ['/help_page/1', '722.247.931.582'],
          ['/help_page/1', '646.865.545.408'],
          ['/home', '235.313.352.950']
        ]
      end
      let(:total_lines) { 8 }

      it { is_expected.to eq(expected_visits_data) }

      it 'adds the line to invalid group' do
        load
        expect(log_file.invalid_lines).to eq(%W[first_invalid_line\n second_invalid_line\n])
      end

      it { expect { load }.to change { Models::Ip.count }.by(total_lines) }
      it { expect { load }.to change { Models::Url.count }.by(total_lines) }
      it { expect { load }.to change { Models::Visit.count }.by(total_lines) }
    end
  end
end
