# frozen_string_literal: true

require_relative 'base_strategy'
require_relative 'union_find'

class EmailStrategy < BaseStrategy
  def find_matches(records)
    union_find = UnionFind.new

    # load records
    records.each { |record| union_find.add(record) }

    records.each do |record|
      record.emails.each do |email|
        next if email.nil?

        # find all records that match on a particular email
        matches = records.select { |r| r.emails.include?(email) }

        # merge all the matches
        matches[1..].each do |match|
          union_find.merge(matches.first, match)
        end
      end
    end

    union_find.groups
  end
end
