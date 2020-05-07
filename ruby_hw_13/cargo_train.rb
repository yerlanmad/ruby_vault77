class CargoTrain < Train
  def initialize(train_number)
    super
    @train_type = "Cargo"
  end

  def attach_car(car)
    return until car.is_a? FreightCar
    super
  end
end
