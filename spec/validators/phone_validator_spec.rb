# frozen_string_literal: true

require 'validators/phone_validator'
require 'validators/validation_error'

RSpec.describe PhoneValidator do
  let(:phone) { nil }
  let(:validate) { PhoneValidator.validate(phone) }

  describe '.validate' do
    context 'when phone is nil' do
      it 'returns true' do
        expect(validate).to eq(true)
      end
    end

    context 'when phone has a valid format' do
      let(:phone) { '1112223333' }

      it 'returns true' do
        expect(validate).to eq(true)
      end
    end

    context 'when phone has an invalid format' do
      let(:phone) { '123' }

      it 'raises a ValidationError' do
        expect { validate }.to raise_error(ValidationError, "Invalid phone number format: #{phone}")
      end
    end
  end
end
