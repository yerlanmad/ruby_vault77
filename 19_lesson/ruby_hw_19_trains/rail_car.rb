class RailCar
  include Manufacturer

  def initialize
    @serial_number = object_id
  end
end

# Вагоны теперь делятся на грузовые и пассажирские
