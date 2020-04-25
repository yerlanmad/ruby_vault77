class PassengerTrain < Train

  def initialize(train_number)
    super
    @train_type = "Passenger"
  end

  def attach_car(car)
    return until car.is_a? PassengerCar
    super
  end
end
