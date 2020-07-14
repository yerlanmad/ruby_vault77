# frozen_string_literal: true

class AppTest
  attr_reader :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def call
    create_stations(7)
    create_trains(5)
    create_routes(3)
    add_railcars
    accept_route
    log
  end

  def create_stations(num)
    num.times do |n|
      stations << Station.new("station_00#{n}")
    end
  end

  def create_trains(num)
    num.times do |n|
      trains << PassengerTrain.new("00#{n}P")
      trains << CargoTrain.new("00#{n}C")
    end
  end

  def create_routes(num)
    num.times do
      routes << Route.new(stations.sample, stations.sample)
    end
  end

  def accept_route
    trains.each { |train| train.accept_route(routes.sample) }
  end

  def add_railcars
    trains.each do |train|
      if train.class == PassengerTrain
        10.times { train.attach_car(PassengerCar.new(40)) }
        train.each_rail_car { |car| rand(40).times { car.take_place } }
      else
        7.times { train.attach_car(CargoCar.new(10_000)) }
        train.each_rail_car { |car| car.fill(rand(10_000)) }
      end
    end
  end

  def log
    stations.each do |station|
      puts "Station:#{station.name}"
      station.each_train do |train|
        puts "Train: #{train.number}, #{train.type}, #{train.rail_cars.size}"
        display_cars(train)
        puts
      end
    end
  end

  def display_cars(train)
    puts 'Railcars:'
    if train.class == PassengerTrain
      train.each_rail_car do |car, number|
        puts "#{number + 1}, #{car.type}, #{car.occupied_seats}, #{car.empty_seats}"
      end
    else
      train.each_rail_car do |car, number|
        puts "#{number + 1}, #{car.type}, #{car.occupied_volume}, #{car.empty_volume}"
      end
    end
  end
end
