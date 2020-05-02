class PassengerCar < RailCar
  attr_reader :number_of_seats
  # При создании пассажирские принимают кол-во мест в вагоне
  def post_initialize(opts)
    @number_of_seats = opts[:seats]
    Validator.validate_nil(@number_of_seats)
    raise Validator::AttributeSizeError until (15..70).include?(@number_of_seats)
  end

  private

  def default_type
    'Coach'
  end

  def default_manufacturer
    'Talgo, S.A.'
  end
end
