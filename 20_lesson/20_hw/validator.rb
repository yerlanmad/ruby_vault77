module Validator
  class AttributeSizeError < StandardError
    def message
      "Attribute's size is not valid"
    end
  end

  class AttributeNilError < StandardError
    def message
      "Attribute is nil"
    end
  end

  def self.validate_nil(attribute)
    raise AttributeNilError if attribute.nil?
  end

  def self.validate_size(attribute)
    raise AttributeSizeError until (2..10).include?(attribute.size)
  end
end
