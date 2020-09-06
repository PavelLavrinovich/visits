# frozen_string_literal: true

require 'spec_helper'
require_relative '../../bin/stat'

RSpec.describe Bin::Stat do
  describe '#display' do
    let(:filename_path) { 'spec/fixtures/webserver.log' }

    it 'reads file with data'

    it 'validates every data line'

    it 'stores the line'

    context 'with invalid line' do
      it 'marks the line as invalid'

      it 'displays invalid lines'
    end

    it 'calculates stat with stored data lines'

    it 'displays the stat'

    context 'when filename_path is nil' do
      let(:filename_path) { nil }

      it 'displays file missing error' do
        expect(run_stat(filename_path)).to eq("Please provide file\n")
      end
    end
    
    context 'when file is missing' do
      let(:filename_path) { 'spec/fixtures/missing.log' }

      it 'displays file missing error' do
        expect(run_stat(filename_path)).to eq("Log file is missing\n")
      end
    end

    context 'when path is missing' do
      let(:filename_path) { 'spec/fixtures/missing/webserver.log' }

      it 'displays pass missing error' do
        expect(run_stat(filename_path)).to eq("Path to the log file is missing\n")
      end
    end

    context 'when file extension is invalid' do
      let(:filename_path) { 'spec/fixtures/webserver.invalid' }

      it 'displays invalid file extension error' do
        expect(run_stat(filename_path)).to eq("File extenstion is invalid (only .log is supported)\n")
      end
    end
  end

  private

  def run_stat(filename_path)
    `ruby bin/stat.rb #{filename_path}`
  end
end
