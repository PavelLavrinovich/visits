# frozen_string_literal: true

require 'spec_helper'
require_relative '../../bin/stat'

RSpec.describe Bin::Stat do
  describe '#display' do
    subject(:displayed_message) { run_stat(filename_path) }

    context 'with valid filename_path' do
      let(:filename_path) { 'spec/fixtures/webserver.log' }
      let(:exptected_stat) do
        "/about/2 90 visits\n/contact 89 visits
        /index 82 visits\n/about 81 visits\n/help_page/1 80 visits\n/home 78 visits
        /help_page/1 23 unique views\n/contact 23 unique views\n/home 23 unique views
        /index 23 unique views\n/about/2 22 unique views\n/about 21 unique views"
      end

      it { is_expected.to match(exptected_stat) }
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
