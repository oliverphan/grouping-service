# frozen_string_literal: true

# Implementation of the Union-Find (disjoint set) data structure
# The current implementation is based on the Quick-Find algorithm with path compression
# Inspired from https://d-halai.com/union-find-algorithms/
class UnionFind
  ##
  # Initializes new instance of UnionFind
  def initialize
    # key: record, value: representative parent record
    @parent = {}
  end

  ##
  # Adds a new record if it is not already present
  #
  # @param record [Record]
  def add(record)
    @parent[record] = record unless @parent.key?(record)
  end

  ##
  # Merges two groups based on the representatives of record1 and record2
  #
  # @param record1 [Record]
  # @param record2 [Record]
  def merge(record1, record2)
    parent1 = find(record1)
    parent2 = find(record2)
    @parent[parent2] = parent1 if parent1 != parent2
  end

  ##
  # Find the representative parent of a record and its group
  #
  # @param record [Record]
  # @return [Record]
  def find(record)
    return record unless @parent.key?(record)

    # If the record is the root, return itself
    return record if @parent[record] == record

    # set the parent
    @parent[record] = find(@parent[record])
  end

  ##
  # Return all groups
  #
  # @return [Array<Array<Record>>]
  def groups
    result = {}
    @parent.each_key do |record|
      parent = find(record)
      result[parent] ||= []
      result[parent] << record
    end
    result.values
  end
end
