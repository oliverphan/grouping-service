# frozen_string_literal: true

require 'rspec'
require 'normalizer'

RSpec.describe Normalizer do
  describe '.normalize_emails' do
    it 'strips whitespace' do
      expect(Normalizer.normalize_emails('  foo@gmail.com  ')).to eq('foo@gmail.com')
    end
  end

  describe '.normalize_phones' do
    it 'returns digits only' do
      expect(Normalizer.normalize_phones('(111) 222-3333')).to eq('1112223333')
    end

    it 'strips leading 1' do
      expect(Normalizer.normalize_phones('+1 (222)-333-4444')).to eq('2223334444')
    end
  end
end
