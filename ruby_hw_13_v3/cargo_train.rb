class CargoTrain < Train
  def initialize(number)
    super
    @type = "Cargo"
  end

  def attach_car(car)
    return unless car.is_a? FreightCar

    super
  end
end
