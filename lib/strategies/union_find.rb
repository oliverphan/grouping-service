# frozen_string_literal: true

# TODO: documentation
class UnionFind
  def initialize
    # key: record
    # value: record (the representative)
    @parent = {}
  end

  # If the record is not there, set its parent to itself
  def add(record)
    @parent[record] = record unless @parent.key?(record)
  end

  # set parent of record #2 to root of record 1
  def merge(record1, record2)
    parent1 = find(record1)
    parent2 = find(record2)
    @parent[parent2] = parent1 if parent1 != parent2
  end

  # find the parent representative of the group
  def find(record)
    return record unless @parent.key?(record)

    # If the record is the root, return itself
    return record if @parent[record] == record

    # set the parent
    @parent[record] = find(@parent[record])
  end

  def groups
    result = {}
    @parent.each_key do |record|
      parent = find(record)
      result[parent] ||= []
      result[parent] << record
    end
    result.values.select { |group| group.size > 1 }
  end
end
