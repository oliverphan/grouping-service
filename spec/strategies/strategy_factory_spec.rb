# frozen_string_literal: true

require 'strategies/strategy_factory'
require 'strategies/email_strategy'
require 'strategies/phone_strategy'
require 'strategies/email_or_phone_strategy'

RSpec.describe StrategyFactory do
  describe '.create' do
    it 'creates an instance of EmailStrategy' do
      expect(StrategyFactory.create('email')).to be_an_instance_of(EmailStrategy)
    end

    it 'creates an instance of PhoneStrategy' do
      expect(StrategyFactory.create('phone')).to be_an_instance_of(PhoneStrategy)
    end

    it 'creates an instance of EmailOrPhoneStrategy' do
      expect(StrategyFactory.create('email_or_phone')).to be_an_instance_of(EmailOrPhoneStrategy)
    end

    it 'raises an error for an unknown strategy' do
      expect { StrategyFactory.create('unknown') }.to raise_error(ArgumentError, 'Unknown strategy: unknown')
    end
  end
end
