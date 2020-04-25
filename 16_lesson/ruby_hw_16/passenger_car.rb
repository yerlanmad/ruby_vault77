class PassengerCar < RailCar
  # При создании пассажирские принимают кол-во мест в вагоне0
  def initialize(seats)
    super()
    @number_of_seats = seats
    @car_type = "Passenger"
  end
end
