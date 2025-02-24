# frozen_string_literal: true

require_relative 'base_strategy'
require_relative 'union_find'

# Strategy for matching records based on phone numbers
class PhoneStrategy < BaseStrategy
  ##
  # Finds matches between records based on shared phone numbers
  #
  # @param records [Array<Record>] An array of records to process
  # @return [Array<Array<Record>>] Groups of matching records
  #
  def find_matches(records)
    union_find = UnionFind.new

    # load records
    records.each { |record| union_find.add(record) }

    records.each do |record|
      record.phones.each do |phone|
        next if phone.nil?

        # find all records that match on a particular phone
        matches = records.select { |r| r.phones.include?(phone) }

        # merge all the matches
        matches[1..].each do |match|
          union_find.merge(matches.first, match)
        end
      end
    end

    union_find.groups
  end
end
