require_relative "rail_car"

class CargoCar < RailCar
  attr_reader :volume

  def initialize(volume)
    @volume = volume
    @type = "Cargo"
  end
end
