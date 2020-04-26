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

  attr_reader :current_speed, :train_number, :train_type, :rail_cars

  def initialize(train_number)
    @train_number = train_number
    raise "ValidationError" unless validate?

    @rail_cars = []
    @current_speed = 0
    @@trains << self
    register_instance
  rescue RuntimeError => e
    puts e.message
    print 'Enter number of train: '
    train_number = gets.chomp
    retry
  end

  def attach_car(car)
    raise "AttachCarError" if current_speed.positive? || rail_cars.count >= MAX_CARS

    @rail_cars << car
  end

  def detach_car
    raise "DetachCarError" if current_speed.positive? || rail_cars.count < MIN_CARS

    @rail_cars.pop
  end

  # Может принимать маршрут следования (объект класса Route).
  def accept_route(route)
    raise "RouteSizeError" if route.stations.size < 2

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
    return until @curr_st < @route.stations.size - 1

    current_station.remove_train(self)
    next_station.accept_train(self)
    @curr_st += 1
  end

  def travel_backward
    return until @curr_st.positive?

    current_station.remove_train(self)
    previous_station.accept_train(self)
    @curr_st -= 1
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def current_station
    @route.stations[@curr_st]
  end

  def previous_station
    @route.stations[@curr_st - 1]
  end

  def next_station
    @route.stations[@curr_st + 1] || @route.stations[0]
  end

  protected

  def speed_up(speed)
    @current_speed += speed
  end

  def stop_train
    @current_speed = 0
  end

  def validate?
    (3..5).include?(train_number.size)
  end
end
