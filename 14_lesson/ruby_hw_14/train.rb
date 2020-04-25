class Train
  MAX_CARS = 30
  MIN_CARS = 1

  attr_reader :current_speed, :train_number, :train_type, :rail_cars

  def initialize(train_number)
    @train_number = train_number
    @rail_cars = []
    @current_speed = 0
  end

  def attach_car(car)
    return if self.current_speed > 0 || self.rail_cars.count >= MAX_CARS
    @rail_cars.push(car)
  end

  def detach_car
    return if self.current_speed > 0 || self.rail_cars.count < MIN_CARS
    @rail_cars.pop
  end

  # Может принимать маршрут следования (объект класса Route).
  def accept_route(route)
    return if route.stations.length < 2
    @route = route
    # При назначении маршрута поезду,
    # поезд автоматически помещается на первую станцию в маршруте.
    @route.stations.first.accept_train(self)
    @current_station = @route.stations.first
  end

  # Может перемещаться между станциями, указанными в маршруте.
  # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  # При этом поезд должен именно переместиться – его не должно быть
  # на текущей станции, но он должен появиться на следующей или предыдущей.
  def move_train(direction)
    case direction
    when "fwd"
      return if @current_station == @route.stations.last
      next_station = @route.stations[@route.stations.index(@current_station) + 1]
      @current_station.send_train(self, next_station)
      @current_station = next_station
    when "backwd"
      return if @current_station == @route.stations.first
      prev_station = @route.stations[@route.stations.index(@current_station) - 1]
      @current_station.send_train(self, prev_station)
      @current_station = prev_station
    end
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def get_station(order_of_station="current")
    case order_of_station
    when "current"
      @current_station.station_name
    when "previous"
      return if @current_station == @route.stations.first
      @route.stations[@route.stations.index(@current_station) - 1].station_name
    when "next"
      return if @current_station == @route.stations.last
      @route.stations[@route.stations.index(@current_station) + 1].station_name
    end
  end

  protected
  def speed_up(speed)
    @current_speed += speed
  end

  def stop_train
    @current_speed = 0
  end
end
