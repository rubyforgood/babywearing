# frozen_string_literal: true

class SubdomainValidator < ActiveModel::EachValidator
  # https://gist.github.com/stuartbain/7212385
  def validate_each(object, attribute, value)
    return unless value.present?

    reserved_names = %w[www ftp mail pop smtp ssl sftp]
    reserved_names = options[:reserved] if options[:reserved]
    object.errors[attribute] << 'cannot be a reserved name' if reserved_names.include?(value)

    check_length(object, attribute, value)
    check_start(object, attribute, value)
    check_alphanumeric(object, attribute, value)
  end

  private

  def check_length(object, attribute, value)
    object.errors[attribute] << 'must have between 3 and 63 characters' unless (3..63).include?(value.length)
  end

  def check_start(object, attribute, value)
    object.errors[attribute] << 'cannot start or end with a hyphen' unless value =~ /\A[^-].*[^-]\z/i
  end

  def check_alphanumeric(object, attribute, value)
    object.errors[attribute] << 'must be alphanumeric (or hyphen)' unless value =~ /\A[a-z0-9\-]*\z/i
  end
end
