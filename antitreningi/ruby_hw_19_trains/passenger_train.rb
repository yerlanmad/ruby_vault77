class PassengerTrain < Train
  def attach_car(car)
    return until car.is_a? PassengerCar
    super
  end

  private

  def default_train_type
    'Passenger'
  end

  def default_manufacturer
    'Talgo, S.A.'
  end
end
