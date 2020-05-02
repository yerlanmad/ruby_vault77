class Train
  include Manufacturer
  include InstanceCounter
  MAX_CARS = 30
  MIN_CARS = 1
  @@trains = []

  # метод класса find, который принимает номер поезда (указанный при его создании)
  # и возвращает объект поезда по номеру или nil,
  # если поезд с таким номером не найден.
  def self.find(number)
    @@trains.find { |tr| tr.train_number == number }
  end

  attr_reader :current_speed, :train_number, :train_type

  def initialize(**opts)
    @train_number = opts[:number]
    Validator.validate_nil(@train_number)
    Validator.validate_size(@train_number)

    @rail_cars = opts[:cars] || []
    @train_type = opts[:type] || default_train_type
    @manufacturer = opts[:manufacturer] || default_manufacturer
    @current_speed = 0
    post_initialize(opts)
    @@trains << self
    register_instance
  rescue Validator::AttributeSizeError => e
    puts e.message
    print 'Enter number of train: '
    opts[:number] = gets.chomp
    retry
  end

  def to_s
    train_number
  end

  def attach_car(car)
    return if current_speed.positive? || number_of_cars >= MAX_CARS

    @rail_cars << car
  end

  def detach_car
    return if current_speed.positive? || number_of_cars < MIN_CARS

    @rail_cars.pop
  end

  # Может принимать маршрут следования (объект класса Route).
  def accept_route(route)
    return if route.stations.size < 2

    @route = route
    # При назначении маршрута поезду,
    # поезд автоматически помещается на первую станцию в маршруте.
    @curr_st = 0
    current_station.accept_train(self)
  end

  # Может перемещаться между станциями, указанными в маршруте.
  # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  # При этом поезд должен именно переместиться – его не должно быть
  # на текущей станции, но он должен появиться на следующей или предыдущей.
  def travel_forward
    Validator.validate_nil(@route)
    return until @curr_st < @route.stations.size - 1

    current_station.remove_train(self)
    next_station.accept_train(self)
    @curr_st += 1
  rescue Validator::AttributeNilError => e
    puts "! #{e.message}: Route is not accepted to the train"
  end

  def travel_backward
    Validator.validate_nil(@route)
    return until @curr_st.positive?

    current_station.remove_train(self)
    previous_station.accept_train(self)
    @curr_st -= 1
  rescue Validator::AttributeNilError => e
    puts "! #{e.message}: Route is not accepted to the train"
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def current_station
    Validator.validate_nil(@route)

    @route.stations[@curr_st]
  rescue Validator::AttributeNilError => e
    puts "! #{e.message}: Route is not accepted to the train"
  end

  def previous_station
    Validator.validate_nil(@route)

    @route.stations[@curr_st - 1]
  rescue Validator::AttributeNilError => e
    puts "! #{e.message}: Route is not accepted to the train"
  end

  def next_station
    Validator.validate_nil(@route)

    @route.stations[@curr_st + 1] || @route.stations[0]
  rescue Validator::AttributeNilError => e
    puts "! #{e.message}: Route is not accepted to the train"
  end

  def number_of_cars
    @rail_cars.size
  end

  protected

  def speed_up(speed)
    @current_speed += speed
  end

  def stop_train
    @current_speed = 0
  end

  # subclasses may override
  def post_initialize(opts); end

  def default_train_type
    'Mixed'
  end
end
