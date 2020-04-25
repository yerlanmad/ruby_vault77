module InstanceCounter

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    attr_accessor :instances
  end

  protected
  def register_instance
    self.class.instances ||= 0
    self.class.instances += 1
  end
end
