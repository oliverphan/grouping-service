# frozen_string_literal: true

require 'uri'
require_relative 'validation_error'

class EmailValidator
  def self.validate(email)
    return true if email.nil?

    raise ValidationError, "Invalid email format: #{email}" unless email.match?(URI::MailTo::EMAIL_REGEXP)

    true
  end
end
