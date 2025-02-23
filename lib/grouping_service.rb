# frozen_string_literal: true

require 'csv'
require_relative 'strategies/strategy_factory'

class GroupingService
  def initialize(matching_strategy)
    @matching_strategy = StrategyFactory.create(matching_strategy)
    @records = []
    @id_counter = 0 # TODO: more sophisticated id generation
    @record_id_mapping = {}
  end

  def load_records(records)
    @records.concat(records)
  end

  def group_records
    return if @records.empty? # TODO: better handling instead of silent fail

    groups = @matching_strategy.find_matches(@records)

    assign_ids_to_groups(groups)

    assign_ids_to_unmatched_records

    @record_id_mapping
  end

  private

  def assign_ids_to_groups(groups)
    groups.each do |group|
      group_id = next_id
      group.each do |record|
        @record_id_mapping[record] = group_id
      end
    end
  end

  def assign_ids_to_unmatched_records
    @records.each do |record|
      next if @record_id_mapping.key?(record)

      @record_id_mapping[record] = next_id
    end
  end

  def next_id
    @id_counter += 1
    @id_counter
  end
end
