class RailCar
  include Manufacturer

  def initialize
    @serial_number = self.object_id
  end
end

# Вагоны теперь делятся на грузовые и пассажирские
