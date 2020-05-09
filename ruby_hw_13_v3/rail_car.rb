class RailCar; end

# Вагоны теперь делятся на грузовые и пассажирские
class FreightCar < RailCar
  # При создании грузовые принимают объем вагона
  def initialize(load)
    @load_capacity = load
    @type = "Cargo"
  end
end

class PassengerCar < RailCar
  # При создании пассажирские принимают кол-во мест в вагоне
  def initialize(seats)
    @seats_ammount = seats
    @type = "Passenger"
  end
end
