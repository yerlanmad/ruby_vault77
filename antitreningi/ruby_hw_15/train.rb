class Train
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
    @rail_cars = []
    @current_speed = 0
    @@trains << self
  end

  def to_s
    train_number
  end

  def attach_car(car)
    return if current_speed.positive? || rail_cars.count >= MAX_CARS

    @rail_cars << car
  end

  def detach_car
    return if current_speed.positive? || rail_cars.count < MIN_CARS

    @rail_cars.pop
  end

  # Может принимать маршрут следования (объект класса Route).
  def accept_route(route)
    return if route.stations.length < 2

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
    return if @route.nil? || @curr_st >= @route.stations.size - 1

    current_station.remove_train(self)
    next_station.accept_train(self)
    @curr_st += 1
  end

  def travel_backward
    return if @route.nil? || @curr_st <= 0

    current_station.remove_train(self)
    previous_station.accept_train(self)
    @curr_st -= 1
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def current_station
    return if @route.nil?

    @route.stations[@curr_st]
  end

  def previous_station
    return if @route.nil?

    @route.stations[@curr_st - 1]
  end

  def next_station
    return if @route.nil?

    @route.stations[@curr_st + 1] || @route.stations[0]
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
end
