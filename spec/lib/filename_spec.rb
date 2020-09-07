# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/filename'

RSpec.describe Lib::Filename do
  describe '#validate' do
    subject(:validate) { filename.validate }

    let(:filename) { described_class.new(filename_path) }

    context 'when filename_path is valid' do
      let(:filename_path) { 'spec/fixtures/webserver.log' }

      it { is_expected.to be_truthy }
    end

    context 'when filename_path is nil' do
      let(:filename_path) { nil }

      it { expect { validate }.to raise_error(ArgumentError, 'Please provide file') }
    end

    context 'when file is missing' do
      let(:filename_path) { 'spec/fixtures/missing.log' }

      it { expect { validate }.to raise_error(ArgumentError, 'Log file is missing') }
    end

    context 'when path is missing' do
      let(:filename_path) { 'spec/fixtures/missing/webserver.log' }

      it { expect { validate }.to raise_error(ArgumentError, 'Path to the log file is missing') }
    end

    context 'when file extension is invalid' do
      let(:filename_path) { 'spec/fixtures/webserver.invalid' }

      it { expect { validate }.to raise_error(ArgumentError, 'File extenstion is invalid') }
    end
  end
end
