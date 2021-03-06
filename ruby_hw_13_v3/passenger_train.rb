class PassengerTrain < Train
  def initialize(number)
    super
    @type = "Passenger"
  end

  def attach_car(car)
    return unless car.is_a? PassengerCar

    super
  end
end
