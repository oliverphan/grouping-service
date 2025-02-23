# frozen_string_literal: true

require 'csv'
require_relative 'models/record'

class CSVHandler
  def initialize(file_path)
    @file_path = file_path
    @records = []
  end

  def read_records
    CSV.foreach(@file_path, headers: true) do |row|
      @records << Record.new(row)
    end
    @records
  end

  def write_output(record_id_mapping)
    CSV.open(output_path, 'wb') do |output_csv|
      original_csv = CSV.read(@file_path, headers: true)

      headers = ['ID'] + original_csv.headers
      output_csv << headers

      original_csv.each_with_index do |row, index|
        record = @records[index]
        id = record_id_mapping[record]
        output_csv << [id] + row.fields
      end
    end

    output_path
  end

  private

  def output_path
    base = File.basename(@file_path, '.*')
    ext = File.extname(@file_path)
    File.join('outputs', "#{base}_grouped#{ext}")
  end
end
