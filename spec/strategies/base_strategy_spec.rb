# frozen_string_literal: true

require 'strategies/base_strategy'

RSpec.describe BaseStrategy do
  subject(:strategy) { described_class.new }

  describe '#find_matches' do
    it 'raises NotImplementedError' do
      expect { strategy.find_matches([]) }.to raise_error(NotImplementedError)
    end
  end
end
