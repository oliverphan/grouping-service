# todo: reading all rows to load into the main class
# writing rows after groups have been made and tagged with IDs

require 'csv'
require_relative 'models/record'

class CSVHandler
  def initialize(file_path)
    @file_path = file_path
  end

  def read_records
    records = []
    CSV.foreach(@file_path, headers: true) do |row|
      records << Record.new(row)
    end
    records
  end

  # TODO
  def write_output
  end
end
