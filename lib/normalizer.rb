class Normalizer
  def self.normalize_emails(email)
    return if email.nil? || email.empty?

    email.strip
  end

  def self.normalize_phones(phone)
    return if phone.nil? || phone.empty?

    digits_only = phone.gsub(/\D/, '')

    # Strip leading 1
    return digits_only [1..] if digits_only.length == 11 && digits_only[0] == '1'

    digits_only
  end
end
