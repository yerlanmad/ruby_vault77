class PassengerCar < RailCar
  # При создании пассажирские принимают кол-во мест в вагоне
  def initialize(seats)
    @number_of_seats = seats
    @car_type = "Passenger"
  end
end
