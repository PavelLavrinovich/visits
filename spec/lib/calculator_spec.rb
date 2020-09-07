# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/calculator'

RSpec.describe Lib::Calculator do
  describe '#calculate' do
    subject(:calculate) { described_class.new.calculate }

    let(:expected_urls_data) do
      [
        ['/first_url', 2, 1],
        ['/first_url', 3, 2]
      ]
    end

    before do
      allow(Models::Url).to receive(:import)
      url = Models::Url.create(id: '/first_url')
      ip = Models::Ip.create(id: '1.1.1.1')
      2.times { Models::Visit.create(url_id: url.id, ip_id: ip.id) }

      second_url = Models::Url.create(id: '/second_url')
      second_ip = Models::Ip.create(id: '2.2.2.2')
      2.times { Models::Visit.create(url_id: second_url.id, ip_id: ip.id) }
      Models::Visit.create(url_id: second_url.id, ip_id: second_ip.id)
    end

    it 'calls Models:Url.import' do
      calculate
      expect(Models::Url).to have_received(:import).with(%i[id visits_count ips_count], expected_urls_data, on_duplicate_key_update: %i[visits_count ips_count])
    end
  end
end
