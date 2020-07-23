# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  def all_instances
    self.class.instances
  end

  protected

  def register_instance
    self.class.instances ||= 0
    self.class.instances += 1
  end
end
