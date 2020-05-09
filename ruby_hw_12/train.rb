class Train
  MAX_CARS = 30
  MIN_CARS = 1

  attr_reader :type, :number
  attr_accessor :current_speed, :cars_amount, :route, :current_station_index

  def initialize(number, type, cars_amount)
    @number = number
    @type = type
    @cars_amount = cars_amount
    self.current_speed = 0
  end

  def speed_up
    self.current_speed += 10
  end

  def stop_train
    self.current_speed = 0
  end

  def attach_car
    return if current_speed.positive? || cars_amount >= MAX_CARS

    self.cars_amount += 1
  end

  def detach_car
    return if current_speed.positive? || cars_amount < MIN_CARS

    self.cars_amount -= 1
  end

  # Может принимать маршрут следования (объект класса Route).
  def accept_route(route)
    self.route = route
    # При назначении маршрута поезду,
    # поезд автоматически помещается на первую станцию в маршруте.
    self.current_station_index = 0
    current_station.accept_train(self)
  end

  # Может перемещаться между станциями, указанными в маршруте.
  # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  # При этом поезд должен именно переместиться – его не должно быть
  # на текущей станции, но он должен появиться на следующей или предыдущей.
  def travel_forward
    return if route.nil? || current_station_index >= route.stations.size - 1

    current_station.remove_train(self)
    next_station.accept_train(self)
    self.current_station_index += 1
  end

  def travel_backward
    return if route.nil? || current_station_index <= 0

    current_station.remove_train(self)
    previous_station.accept_train(self)
    self.current_station_index -= 1
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def current_station
    route&.stations&.[](current_station_index)
  end

  def previous_station
    route&.stations&.[](current_station_index - 1)
  end

  def next_station
    route&.stations&.[](current_station_index + 1) || route&.stations&.first
  end
end
