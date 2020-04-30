# frozen_string_literal: true

# class CargoTrain
class CargoTrain < Train
  def attach_car(car)
    return until car.is_a? FreightCar
    super
  end

  private

  def default_train_type
    'Cargo'
  end

  def default_manufacturer
    'United Wagon Company'
  end
end
