# frozen_string_literal: true

require_relative 'rail_car'

class CargoCar < RailCar
  attr_reader :capacity, :type, :occupied_volume

  def initialize(capacity)
    @capacity = capacity
    @type = 'Cargo'
    @occupied_volume = 0
    validate
    write_log("#{type}, capacity: #{capacity}") if valid?
  end

  def fill(volume)
    self.occupied_volume += volume if (occupied_volume + volume) <= capacity
  end

  def empty_volume
    capacity - occupied_volume
  end

  private

  attr_writer :occupied_volume

  def validate
    super(capacity)
    raise AttributeSizeError unless (5_000..40_000).include?(capacity)
  rescue AttributeSizeError, AttributePresentError => e
    write_error(e.message)
    self.valid = false
  else
    self.valid = true
  end
end
