#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/csv_handler'
require_relative '../lib/grouping_service'

def run(args)
  # parse_options(args)
  validate(args)
  process(args)
rescue StandardError => e
  handle_error(e)
end

def handle_error(error)
  puts "Error: #{error.message}"
  exit 1
end

def validate(args)
  if args.length != 2
    puts 'Error: Expected two arguments, input file and matching strategy'
    exit 1
  end

  file_path = args[0]
  raise "Input file '#{file_path}' does not exist" unless File.exist?(file_path)
  raise 'Input file must be a CSV file' if File.extname(file_path).downcase != '.csv'
end

def process(args)
  file_path = args[0]
  matching_strategy_name = args[1]

  puts "Processing #{file_path} using #{matching_strategy_name} strategy..."

  csv_handler = CSVHandler.new(file_path)
  records = csv_handler.read_records

  grouping_service = GroupingService.new(matching_strategy_name)
  grouping_service.load_records(records)
  record_id_mapping = grouping_service.group_records

  output_path = csv_handler.write_output(record_id_mapping)

  puts "Output written to: #{output_path}"
end

run(ARGV)
