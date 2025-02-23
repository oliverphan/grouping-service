# frozen_string_literal: true

require_relative 'base_strategy'
require_relative 'union_find'

class EmailOrPhoneStrategy < BaseStrategy
  def find_matches(records)
    union_find = UnionFind.new
    records.each { |record| union_find.add(record) }

    # match by email
    records.each do |record|
      record.emails.each do |email|
        next if email.nil?

        matches = records.select { |r| r.emails.include?(email) }
        matches[1..]&.each { |match| union_find.merge(matches.first, match) }
      end
    end

    # match by phone
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
