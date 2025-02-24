# frozen_string_literal: true

require 'csv'
require_relative 'strategies/strategy_factory'

# Service for performing operations to grouping records based on a matching strategy
class GroupingService
  ##
  # Initialize with given matching strategy
  #
  # @param matching_strategy [String] The name of the strategy to create.
  # @raise [ArgumentError]
  def initialize(matching_strategy)
    @matching_strategy = StrategyFactory.create(matching_strategy)
    @records = []
    @id_counter = 0
    @record_id_mapping = {}
  end

  ##
  # Load a collection of records
  #
  # @param records [Array<Record>]
  def load_records(records)
    @records.concat(records)
  end

  ##
  # Group records with specified matching strategy and
  # assign IDs to groups, which designate if the records
  # could represent the same person
  #
  # @return [Hash] mapping of records to their id
  def group_records
    return if @records.empty? # TODO: better handling instead of silent fail

    groups = @matching_strategy.find_matches(@records)

    assign_ids_to_groups(groups)

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

  def next_id
    @id_counter += 1
    @id_counter
  end
end
