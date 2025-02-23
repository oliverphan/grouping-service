# frozen_string_literal: true

require_relative '../lib/csv_handler'
require_relative '../lib/grouping_service'

file_path = ARGV[0]
matching_strategy_name = ARGV[1]

csv_handler = CSVHandler.new(file_path)
records = csv_handler.read_records

grouping_service = GroupingService.new(matching_strategy_name)
grouping_service.load_records(records)
record_id_mapping = grouping_service.group_records

csv_handler.write_output(record_id_mapping)
