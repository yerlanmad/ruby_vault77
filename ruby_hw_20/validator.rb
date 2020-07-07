# frozen_string_literal: true

module Validator
  class AttributeSizeError < StandardError
    def message
      "Attribute's size is not valid"
    end
  end

  class AttributePresentError < StandardError
    def message
      'Attribute is not present'
    end
  end

  def present?(object)
    !(object.nil? || object == '' || object == 0 || object == [])
  end

  def valid_size?(object)
    (2..50).include?(object.size)
  end

  def validate(object)
    raise AttributePresentError unless present?(object)
    raise AttributeSizeError unless valid_size?(object)
  end
end
