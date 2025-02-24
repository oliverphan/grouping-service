# frozen_string_literal: true

require_relative 'email_strategy'
require_relative 'phone_strategy'
require_relative 'email_or_phone_strategy'

# Factory class for creating matching strategies
class StrategyFactory
  STRATEGIES = {
    'email' => EmailStrategy,
    'phone' => PhoneStrategy,
    'email_or_phone' => EmailOrPhoneStrategy
  }.freeze

  ##
  # Creates an instance of a matching strategy
  # @param matching_strategy [String] The name of the strategy to create.
  # @return [BaseStrategy]
  # @raise [ArgumentError] If the startegy name is unknown
  def self.create(matching_strategy)
    raise ArgumentError, "Unknown strategy: #{matching_strategy}" unless STRATEGIES.key?(matching_strategy)

    strategy_class = STRATEGIES[matching_strategy]
    strategy_class.new
  end
end
