# frozen_string_literal: true

require 'strategies/union_find'

RSpec.describe UnionFind do
  let(:union_find) { UnionFind.new }

  describe '#add' do
    it 'adds a new record' do
      union_find.add(1)
      expect(union_find.find(1)).to eq(1)
    end
  end

  describe '#merge' do
    it 'merges two elements into the same group' do
      union_find.add(1)
      union_find.add(2)
      union_find.merge(1, 2)
      expect(union_find.find(2)).to eq(union_find.find(1))
    end
  end

  describe '#find' do
    it 'finds the representative parent of an element' do
      union_find.add(5)
      union_find.add(6)
      union_find.merge(5, 6)
      union_find.add(1)
      union_find.add(2)
      union_find.merge(1, 2)
      union_find.merge(6, 2)
      expect(union_find.find(2)).to eq(5)
    end
  end

  describe '#groups' do
    it 'returns groupings' do
      union_find.add(1)
      union_find.add(2)
      union_find.add(3)
      union_find.merge(1, 2)
      union_find.merge(2, 3)
      expect(union_find.groups).to eq([[1, 2, 3]])
    end
  end
end
