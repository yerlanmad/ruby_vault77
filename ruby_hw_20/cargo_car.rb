# frozen_string_literal: true

require_relative 'rail_car'

class CargoCar < RailCar
  attr_reader :volume

  def initialize(volume)
    @volume = volume
    @type = 'Cargo'
    validate
  end

  def validate
    super(volume)
    raise AttributeSizeError unless (5_000..40_000).include?(volume)
  end
end
