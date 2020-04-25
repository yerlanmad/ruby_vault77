class FreightCar < RailCar
  # При создании грузовые принимают объем вагона
  def initialize(load)
    super()
    @load_capacity = load
    @car_type = "Cargo"
  end
end
