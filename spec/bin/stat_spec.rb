# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bin::Stat do
  describe '#display' do
    let(:filename_path) { 'spec/fixtures/webserver.log' }

    before do
      run_stat(filename_path)
    end

    it 'reads file with data'

    it 'validates every data line'

    it 'stores the line'

    context 'with invalid line' do
      it 'marks the line as invalid'

      it 'displays invalid lines'
    end

    it 'calculates stat with stored data lines'

    it 'displays the stat'

    context 'when file is missing' do
      let(:filename_path) { 'spec/fixtures/missing.log' }

      it 'handles file missing error'

      it 'displays file missing error'
    end

    context 'when path is missing' do
      let(:filename_path) { 'spec/fixtures/missing/webserver.log' }

      it 'handles path missing error'

      it 'displays pass missing error'
    end

    context 'when file extension is invalid' do
      let(:filename_path) { 'spec/fixtures/webserver.invalid' }

      it 'handles invalid file extension error'

      it 'displays invalid file extension error'
    end
  end

  private

  def run_stat(filename_path)
    system "ruby bin/stat.rb #{filename_path}"
  end
end
