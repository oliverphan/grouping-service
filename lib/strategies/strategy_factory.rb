# frozen_string_literal: true

require_relative 'email_strategy'
require_relative 'phone_strategy'
require_relative 'email_or_phone_strategy'

class StrategyFactory
  STRATEGIES = {
    'email' => EmailStrategy,
    'phone' => PhoneStrategy,
    'email_or_phone' => EmailOrPhoneStrategy
  }.freeze

  def self.create(matching_strategy)
    raise ArgumentError, "Unknown strategy: #{matching_strategy}" unless STRATEGIES.key?(matching_strategy)

    strategy_class = STRATEGIES[matching_strategy]
    strategy_class.new
  end
end
