class CargoCar < RailCar
  attr_reader :volume

  # При создании грузовые принимают объем вагона
  def initialize(volume)
    @volume = volume
    @type = "Cargo"
  end
end
