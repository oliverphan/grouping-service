# frozen_string_literal: true

require 'validators/email_validator'
require 'validators/validation_error'

RSpec.describe EmailValidator do
  let(:email) { nil }
  let(:validate) { EmailValidator.validate(email) }

  describe '.validate' do
    context 'when email is nil' do
      it 'returns true' do
        expect(validate).to eq(true)
      end
    end

    context 'when email has a valid format' do
      let(:email) { 'foo@gmail.com' }

      it 'returns true' do
        expect(validate).to eq(true)
      end
    end

    context 'when email has an invalid format' do
      let(:email) { 'foogmail.com' }

      it 'raises a ValidationError' do
        expect { validate }.to raise_error(ValidationError, "Invalid email format: #{email}")
      end
    end
  end
end
