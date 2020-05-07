# railways.rb

class Station
  attr_reader :station_name

  def initialize(name)
    @station_name = name
  end
end

class Route
  attr_reader :stations

  def initialize(*args)
    @stations = args
  end

  def get_stations
    stations.each { |el| p el.station_name }
  end
end

class Train
  MAX_CARS = 30
  MIN_CARS = 1

  attr_reader :current_speed, :number_of_cars

  def initialize(train_number, train_type, number_of_cars)
    @train_number = train_number
    @train_type = train_type
    @number_of_cars = number_of_cars
    @current_speed = 0
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
end

almaty = Station.new("Almaty 1")

nur_sultan = Station.new("Nurly Zhol")

almaty_nur_sultan = Route.new(almaty, nur_sultan)
almaty_nur_sultan.get_stations

talgo111 = Train.new("111x", "P", 17)
talgo111.speed_up(50)
talgo111.current_speed
talgo111.stop_train
talgo111.current_speed
talgo111.attach_car
talgo111.detach_car
