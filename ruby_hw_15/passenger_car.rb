require_relative "rail_car"

class PassengerCar < RailCar
  attr_reader :seats_amount

  # При создании пассажирские принимают кол-во мест в вагоне
  def initialize(seats)
    @seats_amount = seats
    @type = "Passenger"
  end
end
