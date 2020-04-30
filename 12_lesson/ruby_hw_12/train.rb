class Train
  MAX_CARS = 30
  MIN_CARS = 1

  attr_reader :current_speed, :number_of_cars, :train_type, :train_number

  def initialize(train_number, train_type, number_of_cars)
    @train_number = train_number
    @train_type = train_type
    @number_of_cars = number_of_cars
    @current_speed = 0
  end

  def to_s
    train_number
  end

  def speed_up(speed)
    @current_speed += speed
  end

  def stop_train
    @current_speed = 0
  end

  def attach_car
    return if current_speed.positive? || number_of_cars >= MAX_CARS

    @number_of_cars += 1
  end

  def detach_car
    return if current_speed.positive? || number_of_cars < MIN_CARS

    @number_of_cars -= 1
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
end
