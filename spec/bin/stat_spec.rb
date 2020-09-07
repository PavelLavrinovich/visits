# frozen_string_literal: true

require 'spec_helper'
require_relative '../../bin/stat'

RSpec.describe Bin::Stat do
  describe '#display' do
    subject(:displayed_message) { run_stat(filename_path) }

    it 'calculates stat with stored data lines'

    context 'with valid filename_path' do
      let(:filename_path) { 'spec/fixtures/webserver.log' }

      it 'displays the stat'
    end

    context 'with invalid line' do
      let(:filename_path) { 'spec/fixtures/webserver_small_with_invalid.log' }

      it { is_expected.to match("Warning: Invalid lines\nfirst_invalid_line\nsecond_invalid_line\n") }
    end

    context 'when filename_path is nil' do
      let(:filename_path) { nil }

      it { is_expected.to match("Please provide file\n") }
    end

    context 'when file is missing' do
      let(:filename_path) { 'spec/fixtures/missing.log' }

      it { is_expected.to match("Log file is missing\n") }
    end

    context 'when path is missing' do
      let(:filename_path) { 'spec/fixtures/missing/webserver.log' }

      it { is_expected.to match("Path to the log file is missing\n") }
    end

    context 'when file extension is invalid' do
      let(:filename_path) { 'spec/fixtures/webserver.invalid' }

      it { is_expected.to match("File extenstion is invalid\n") }
    end
  end

  private

  def run_stat(filename_path)
    `ruby bin/stat.rb #{filename_path}`
  end
end
