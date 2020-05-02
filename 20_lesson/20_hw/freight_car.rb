class FreightCar < RailCar
  # При создании грузовые принимают объем вагона
  def post_initialize(opts)
    @load_capacity = opts[:load]
    Validator.validate_nil(@load_capacity)
    raise Validator::AttributeSizeError until (5000..40000).include?(@load_capacity)
  end

  private

  def default_type
    'Boxcar'
  end

  def default_manufacturer
    'United Wagon Company'
  end
end
