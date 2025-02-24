# frozen_string_literal: true

require_relative 'base_strategy'
require_relative 'union_find'

# Strategy for matching records based on phone numbers or email addresses
class EmailOrPhoneStrategy < BaseStrategy
  ##
  # Finds matches between records based on
  # shared phone numbers OR email addresses
  #
  # @param records [Array<Record>] An array of records to process
  # @return [Array<Array<Record>>] Groups of matching records
  #
  def find_matches(records)
    union_find = UnionFind.new
    records.each { |record| union_find.add(record) }

    records.each do |record|
      record.emails.each do |email|
        next if email.nil?

        matches = records.select { |r| r.emails.include?(email) }
        matches[1..]&.each { |match| union_find.merge(matches.first, match) }
      end
    end

    records.each do |record|
      record.phones.each do |phone|
        next if phone.nil?

        matches = records.select { |r| r.phones.include?(phone) }
        matches[1..]&.each { |match| union_find.merge(matches.first, match) }
      end
    end

    union_find.groups
  end
end
