require_relative "rail_car"

class PassengerCar < RailCar
  attr_reader :seats_amount

  def initialize(seats)
    @seats_amount = seats
    @type = "Passenger"
  end
end
