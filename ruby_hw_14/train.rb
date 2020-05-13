class Train
  MAX_CARS = 30
  MIN_CARS = 1

  attr_reader :number, :type, :rail_cars, :current_speed

  def initialize(number)
    @number = number
    self.rail_cars = []
    self.current_speed = 0
  end

  def attach_car(car)
    return if current_speed.positive? || cars_amount >= MAX_CARS

    rail_cars << car
  end

  def detach_car
    return if current_speed.positive? || cars_amount < MIN_CARS

    rail_cars.pop
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
    return unless next_station

    current_station.remove_train(self)
    next_station.accept_train(self)
    self.current_station_index += 1
  end

  def travel_backward
    return unless previous_station

    current_station.remove_train(self)
    previous_station.accept_train(self)
    self.current_station_index -= 1
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def current_station
    route&.stations&.[](current_station_index)
  end

  def previous_station
    route&.stations&.[](current_station_index - 1) if current_station_index.positive?
  end

  def next_station
    route&.stations&.[](current_station_index + 1)
  end

  def cars_amount
    rail_cars.size
  end

  def speed_up
    self.current_speed += 10
  end

  def stop_train
    self.current_speed = 0
  end

  protected

  attr_accessor :route, :current_station_index
  attr_writer :current_speed, :rail_cars
end
