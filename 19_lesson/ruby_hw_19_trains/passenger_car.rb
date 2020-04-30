class PassengerCar < RailCar
  attr_reader :number_of_seats
  # При создании пассажирские принимают кол-во мест в вагоне
  def post_initialize(opts)
    @number_of_seats = opts[:seats]
  end

  private

  def default_type
    'Coach'
  end

  def default_manufacturer
    'Talgo, S.A.'
  end
end
