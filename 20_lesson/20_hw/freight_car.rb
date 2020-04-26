class FreightCar < RailCar
  # При создании грузовые принимают объем вагона
  def post_initialize(opts)
    @load_capacity = opts[:load]
  end

  private

  def default_type
    'Boxcar'
  end

  def default_manufacturer
    'United Wagon Company'
  end
end
