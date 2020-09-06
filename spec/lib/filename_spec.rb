# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/filename'

RSpec.describe Lib::Filename do
  describe '#validate' do
    let(:filename_path) { 'spec/fixtures/webserver.log' }
    let(:filename) { described_class.new(filename_path) }

    it 'returns true for a valid file' do
      expect(filename.validate).to be_truthy
    end

    context 'when filename_path is nil' do
      let(:filename_path) { nil }

      it 'raises please provide file error' do
        expect { filename.validate }.to raise_error(ArgumentError, 'Please provide file')
      end
    end

    context 'when file is missing' do
      let(:filename_path) { 'spec/fixtures/missing.log' }

      it 'raises file missing error' do
        expect { filename.validate }.to raise_error(ArgumentError, 'Log file is missing')
      end
    end

    context 'when path is missing' do
      let(:filename_path) { 'spec/fixtures/missing/webserver.log' }

      it 'raises path missing error' do
        expect { filename.validate }.to raise_error(ArgumentError, 'Path to the log file is missing')
      end
    end

    context 'when file extension is invalid' do
      let(:filename_path) { 'spec/fixtures/webserver.invalid' }

      it 'raises invalid file extension error' do
        expect { filename.validate }.to raise_error(ArgumentError, 'File extenstion is invalid')
      end
    end
  end
end
