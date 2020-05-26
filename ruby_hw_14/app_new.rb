class App
  attr_reader :stations, :trains, :routes, :menu, :train_klass

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @menu = [
      ["1. Create station", :create_station],
      ["2. Create route", :create_route],
      ["3. Create train", :create_train],
      ["4. Add station to route", :add_station],
      ["5. Delete station from route", :remove_station],
      ["6. Accept route to train", :accept_route],
      ["7. Add railcar", :add_railcar],
      ["8. Remove railcar", :remove_railcar],
      ["9. Move train forward", :move_train_forward],
      ["10. Move train backward", :move_train_backward],
      ["11. Show stations", :show_stations],
      ["12. Trains on station", :trains_on_station],
      ["\n13. Quit", :quit],
      ["14. Log", :log]
    ]
    @train_klass = [PassengerTrain, CargoTrain]
  end

  def menu_loop
    loop do
      menu.each { |item| puts item[0] }
      choice1 = prompt_index("Select from menu: ", menu)
      next unless choice1

      send(menu[choice1][1])
      break if menu[choice1][1] == :quit
    end
  end

  def create_station
    name = prompt_string("Enter Station name: ")
    return unless name

    stations << Station.new(name)
  end

  def create_train
    puts "1. Passenger Train"
    puts "2. Cargo Train"
    index = prompt_index("Choose train type: ", train_klass)
    number = prompt_string("Enter Train number: ")
    return unless index && number

    trains << train_klass[index].new(number)
  end

  def create_route
    show(stations)
    first = prompt_index("Choose first station for route: ", stations)
    last = prompt_index("Choose last station for route: ", stations)
    return unless first && last

    routes << Route.new(stations[first], stations[last])
  end

  def add_station
    choice1 = choice(routes)
    choice2 = choice(stations)
    return unless choice1 && choice2

    routes[choice1].add_station(stations[choice2])
  end

  def remove_station
    choice1 = choice(routes)
    choice2 = choice(stations)
    return unless choice1 && choice2

    routes[choice1].delete_station(stations[choice2])
  end

  def accept_route
    choice1 = choice(trains)
    choice2 = choice(routes)
    return unless choice1 && choice2

    trains[choice1].accept_route(routes[choice2])
  end

  def add_railcar
    choice1 = choice(trains)
    return unless choice1

    if trains[choice1].type == "Passenger"
      print "Enter number of seats: "
      trains[choice1].attach_car(PassengerCar.new(gets.to_i))
    elsif trains[choice1].type == "Cargo"
      print 'Enter load mass: '
      trains[choice1].attach_car(CargoCar.new(gets.to_i))
    end
  end

  def remove_railcar
    choice1 = choice(trains)
    return unless choice1

    trains[choice1].detach_car
  end

  def move_train_forward
    choice1 = choice(trains)
    return unless choice1

    trains[choice1].travel_forward
  end

  def move_train_backward
    choice1 = choice(trains)
    return unless choice1

    trains[choice1].travel_backward
  end

  def trains_on_station
    choice1 = choice(stations)
    return unless choice1

    puts stations[choice1].trains_name
  end

  def show(list)
    list.map(&:name).each_with_index { |value, index| puts "#{index + 1}. #{value}" }
  end

  def quit
    puts "Good Buy"
  end

  def prompt_index(title, list)
    print "\n" + title
    index = gets.to_i - 1
    return if index.negative? || list[index].nil?

    index
  end

  def prompt_string(title)
    print "\n" + title
    string = gets.chomp.strip
    return if string.empty?

    string
  end

  def choice(list)
    show(list)
    title = case list
            when trains
              "Select train: "
            when routes
              "Select route: "
            when stations
              "Select station: "
            else
              "Select menu item: "
            end
    prompt_index(title, list)
  end

  def show_stations
    show(stations)
  end

  def log
    puts "\nStations:"
    puts stations.map { |station| "#{station.name}(#{station.trains_name})" }.join("\n")
    puts "\nTrains"
    puts trains.map(&:name).join("\n")
    puts "\nRoutes"
    puts routes.map { |route| "#{route.name}(#{route.stations_name.join("\n\t")})" }.join("\n")
  end
end
