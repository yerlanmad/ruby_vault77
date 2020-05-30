class Train
  MAX_CARS = 30
  MIN_CARS = 1
  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  attr_reader :number, :type, :rail_cars, :current_speed

  def initialize(number)
    @number = number
    @rail_cars = []
    @current_speed = 0
    @@trains << self
  end

  def attach_car(car)
    return if current_speed.positive? || rail_cars.size >= MAX_CARS

    rail_cars << car
  end

  def detach_car
    return if current_speed.positive? || rail_cars.size < MIN_CARS

    rail_cars.pop
  end

  def accept_route(route)
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)
  end

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
    @current_speed += 10
  end

  def stop_train
    @current_speed = 0
  end

  def name
    "#{number}(#{type})"
  end

  protected

  attr_accessor :route, :current_station_index
end
