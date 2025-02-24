# frozen_string_literal: true

# Interface for different matching strategies
# Subclasses should implement the find_matches method
class BaseStrategy
  ##
  # Returns groupings from an array of records based on the matching strategy
  # @param records [Array<Record>]
  # @raise [NotImplementedError]
  def find_matches(records)
    raise NotImplementedError
  end
end
