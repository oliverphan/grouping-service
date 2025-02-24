# frozen_string_literal: true

require 'csv'
require_relative 'models/record'

# Service for performing operations to grouping records based on a matching strategy
class CSVHandler
  ##
  # Initialize with given file path
  #
  # @param file_path [String]
  def initialize(file_path)
    @file_path = file_path
    @records = []
  end

  ##
  # Read rows of CSV and transform into record objects
  #
  # @return records [Array<Record>]
  def read_records
    CSV.foreach(@file_path, headers: true).with_index do |row, index|
      @records << Record.new(row, index)
    end
    @records
  end

  ##
  # Given a hash of grouped records,
  # write the original data to a new CSV
  # with a unique identifier of the person each row represents
  # prepended to the row
  #
  # @params record_id_mapping[Hash{Record => Integer}]
  # @return [String] path of output file
  def write_output(record_id_mapping)
    CSV.open(output_path, 'wb') do |output_csv|
      original_csv = CSV.read(@file_path, headers: true)

      headers = ['ID'] + original_csv.headers
      output_csv << headers

      original_csv.each_with_index do |row, index|
        record = @records[index]
        output_csv << [record_id_mapping[record]] + row.fields
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
