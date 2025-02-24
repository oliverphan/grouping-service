# frozen_string_literal: true

require_relative 'validation_error'

class PhoneValidator
  VALID_PHONE_LENGTHS = [11, 10].freeze

  def self.validate(phone)
    return true if phone.nil?

    raise ValidationError, "Invalid phone number format: #{phone}" unless VALID_PHONE_LENGTHS.include?(phone.length)

    true
  end
end
