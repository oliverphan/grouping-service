require_relative '../lib/csv_handler'

file_path = ARGV[0]
matching_strategy_name = ARGV[1]

puts file_path
puts matching_strategy_name

csv_handler = CSVHandler.new(file_path)
records = csv_handler.read_records

puts records.size

# grouper = GroupingService.new(matching_strategy_name)
# matcher.add_records(records)
# grouped_records = grouper.group_records

# csv_handler.write_output(grouped_records)
