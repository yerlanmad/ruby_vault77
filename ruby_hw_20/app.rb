# frozen_string_literal: true

class App
  attr_reader :stations, :trains, :routes, :menu_options, :train_klass

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @menu_options = {
      "Create station": :create_station,
      "Create route": :create_route,
      "Create train": :create_train,
      "Add station to route": :add_station,
      "Delete station from route": :remove_station,
      "Accept route to train": :accept_route,
      "Add railcar": :add_railcar,
      "Remove railcar": :remove_railcar,
      "Move train forward": :move_train_forward,
      "Move train backward": :move_train_backward,
      "Show stations": :show_stations,
      "Trains on station": :trains_on_station,
      "Quit": :quit,
      "Log": :log
    }
    @train_klass = {
      "Passenger Train": PassengerTrain,
      "Cargo Train": CargoTrain
    }
  end

  def menu
    loop do
      puts
      index = choice('Select from menu: ', menu_options.keys)
      next unless index

      send(menu_options.values[index])
      break if menu_options.values[index] == :quit
    end
  end

  def create_station
    name = prompt_string('Enter Station name: ')
    return unless name

    stations << Station.new(name)
  end

  def create_train
    index = choice('Choose train type: ', train_klass.keys)
    number = prompt_string('Enter Train number: ')
    return unless index

    trains << train_klass.values[index].new(number)
  end

  def create_route
    first = choice('Choose first station for route: ', stations.map(&:name))
    last = prompt_index('Choose last station for route: ', stations.map(&:name))
    return unless first && last

    routes << Route.new(stations[first], stations[last])
  end

  def add_station
    route_index = choice('Choose route: ', routes.map(&:name))
    station_index = choice('Choose station: ', stations.map(&:name))
    return unless route_index && station_index

    routes[route_index].add_station(stations[station_index])
  end

  def remove_station
    route_index = choice('Choose route: ', routes.map(&:name))
    station_index = choice('Choose station: ', stations.map(&:name))
    return unless route_index && station_index

    routes[route_index].delete_station(stations[station_index])
  end

  def accept_route
    train_index = choice('Choose train: ', trains.map(&:name))
    route_index = choice('Choose route: ', routes.map(&:name))
    return unless train_index && route_index

    trains[train_index].accept_route(routes[route_index])
  end

  def add_railcar
    train_index = choice('Choose train: ', trains.map(&:name))
    return unless train_index

    if trains[train_index].is_a? PassengerTrain
      print 'Enter number of seats: '
      trains[train_index].attach_car(PassengerCar.new(gets.to_i))
    elsif trains[train_index].is_a? CargoTrain
      print 'Enter load mass: '
      trains[train_index].attach_car(CargoCar.new(gets.to_i))
    end
  end

  def remove_railcar
    train_index = choice('Choose train: ', trains.map(&:name))
    return unless train_index

    trains[train_index].detach_car
  end

  def move_train_forward
    train_index = choice('Choose train: ', trains.map(&:name))
    return unless train_index

    trains[train_index].travel_forward
  end

  def move_train_backward
    train_index = choice('Choose train: ', trains.map(&:name))
    return unless train_index

    trains[train_index].travel_backward
  end

  def trains_on_station
    station_index = choice('Choose station: ', stations.map(&:name))
    return unless station_index

    puts stations[station_index].trains_name
  end

  def options(list)
    list.each_with_index { |value, index| puts "#{index + 1}. #{value}" }
  end

  def quit
    puts 'Goodbye'
  end

  def prompt_index(title, list)
    print title
    index = gets.to_i - 1
    return if index.negative? || list[index].nil?

    index
  end

  def prompt_string(title)
    print title
    string = gets.chomp.strip
    return if string.empty?

    string
  end

  def choice(title, list)
    options(list)
    prompt_index(title, list)
  end

  def show_stations
    options(stations.map(&:name))
  end

  def log
    puts "\nStations:"
    puts stations.map { |station| "#{station.name}(#{station.trains_name})" }.join("\n")
    puts "\nTrains:"
    puts trains.map(&:name).join("\n")
    puts "\nRoutes:"
    puts routes.map { |route| "#{route.name}(#{route.stations_name.join("\n\t")})" }.join("\n")
  end
end
