# frozen_string_literal: true

module Validator
  protected

  def present?(attribute)
    !(attribute.nil? || attribute == '' || attribute == 0 || attribute == [])
  end

  def valid_size?(attribute)
    (2..50).include?(attribute.size)
  end

  def validate(attribute)
    raise AttributePresentError unless present?(attribute)
    raise AttributeSizeError unless valid_size?(attribute)
  end
end
