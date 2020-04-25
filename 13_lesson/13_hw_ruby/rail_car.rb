class RailCar
  def initialize(capacity)
    @serial_number = self.object_id
  end
end

# Вагоны теперь делятся на грузовые и пассажирские
class FreightCar < RailCar
  # При создании грузовые принимают объем вагона
  def initialize(load)
    super
    @load_capacity = load
    @car_type = "Cargo"
  end
end

class PassengerCar < RailCar
  # При создании пассажирские принимают кол-во мест в вагоне
  def initialize(seats)
    super
    @number_of_seats = seats
    @car_type = "Passenger"
  end
end
