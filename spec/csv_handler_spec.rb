# frozen_string_literal: true

require 'csv_handler'
require 'csv'

RSpec.describe CSVHandler do
  let(:file_path) { 'spec/fixtures/input1.csv' }
  let(:csv_handler) { CSVHandler.new(file_path) }
  let(:record_id_mapping) { { instance_of(Record) => 123 } }

  let(:csv_headers) { %w[FirstName LastName Phone Email Zip] }

  describe '#read_records' do
    let(:output_record1) do
      Record.new(
        CSV::Row.new(csv_headers, ['John', 'Smith', '(555) 123-4567', 'johns@home.com', 94_105]),
        1
      )
    end

    it 'reads records from the CSV file and creates record objects' do
      records = csv_handler.read_records
      expect(records.first.emails).to eq(output_record1.emails)
      expect(records.first.phones).to eq(output_record1.phones)
    end
  end

  describe '#write_output' do
    it 'writes to a new CSV file with IDs' do
      allow(CSV).to receive(:read).and_return([CSV::Row.new(['Header'], ['Value'])])
      allow(CSV).to receive(:open)

      output_path = csv_handler.write_output(record_id_mapping)

      expect(output_path).to eq('outputs/input1_grouped.csv')
    end
  end
end
