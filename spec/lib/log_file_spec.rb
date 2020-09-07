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
    let(:expected_ips_data) do
      [
        ['126.318.035.038'],
        ['184.123.665.067'],
        ['184.123.665.067'],
        ['444.701.448.104'],
        ['929.398.951.889'],
        ['444.701.448.104'],
        ['722.247.931.582'],
        ['061.945.150.735'],
        ['646.865.545.408'],
        ['235.313.352.950']
      ]
    end
    let(:expected_urls_data) do
      [
        ['/help_page/1'],
        ['/contact'],
        ['/home'],
        ['/about/2'],
        ['/help_page/1'],
        ['/index'],
        ['/help_page/1'],
        ['/about'],
        ['/help_page/1'],
        ['/home']
      ]
    end
    
    before do
      allow(Models::Ip).to receive(:import)
      allow(Models::Url).to receive(:import)
      allow(Models::Visit).to receive(:import)
    end

    it { is_expected.to eq(expected_visits_data) }

    it 'calls Models::Ip.import' do
      load
      expect(Models::Ip).to have_received(:import).with(%i[id], expected_ips_data, on_duplicate_key_ignore: true)
    end

    it 'calls Models::Url.import' do
      load
      expect(Models::Url).to have_received(:import).with(%i[id], expected_urls_data, on_duplicate_key_ignore: true)
    end

    it 'calls Models::Visit.import' do
      load
      expect(Models::Visit).to have_received(:import).with(%i[url_id ip_id], expected_visits_data)
    end

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
      let(:expected_ips_data) do
        [
          ['126.318.035.038'],
          ['184.123.665.067'],
          ['444.701.448.104'],
          ['929.398.951.889'],
          ['444.701.448.104'],
          ['722.247.931.582'],
          ['646.865.545.408'],
          ['235.313.352.950']
        ]
      end
      let(:expected_urls_data) do
        [
          ['/help_page/1'],
          ['/contact'],
          ['/about/2'],
          ['/help_page/1'],
          ['/index'],
          ['/help_page/1'],
          ['/help_page/1'],
          ['/home']
        ]
      end

      it { is_expected.to eq(expected_visits_data) }

      it 'adds the line to invalid group' do
        load
        expect(log_file.invalid_lines).to eq(%W[first_invalid_line\n second_invalid_line\n])
      end

      it 'calls Models::Ip.import' do
        load
        expect(Models::Ip).to have_received(:import).with(%i[id], expected_ips_data, on_duplicate_key_ignore: true)
      end
  
      it 'calls Models::Url.import' do
        load
        expect(Models::Url).to have_received(:import).with(%i[id], expected_urls_data, on_duplicate_key_ignore: true)
      end
  
      it 'calls Models::Visit.import' do
        load
        expect(Models::Visit).to have_received(:import).with(%i[url_id ip_id], expected_visits_data)
      end
    end
  end
end
