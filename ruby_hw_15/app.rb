class App
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def main_menu
    system 'clear'
    print "| 1 | Stations\n| 2 | Routes\n| 3 | Trains\n| 0 | Exit\nSelect from Main menu: "

    case gets.chomp
    when '1'
      stations_menu
    when '2'
      routes_menu
    when '3'
      trains_menu
    when '0'
      puts 'Good bye'
    else
      puts 'Wrong choice'
      main_menu
    end
  end

  private

  def stations_menu
    print "| 1 | Create station\n| 2 | Get list of trains\n| 0 | Back\nSelect from Stations menu: "

    case gets.chomp
    when '1'
      print 'Enter name of station: '
      @stations << Station.new(gets.chomp)
      puts @stations.map(&:name).join(' | ')
      stations_menu
    when '2'
      choose_station_menu

      menu_item = gets.chomp.to_i
      case menu_item
      when (1..@stations.size)
        puts @stations[menu_item - 1].trains.map(&:number).join(' | ')
      else
        puts 'Wrong choice'
      end
      stations_menu
    when '0'
      main_menu
    else
      puts 'Wrong choice'
      stations_menu
    end
  end

  def routes_menu
    print "| 1 | Create route\n| 2 | Add station in route\n" +
          "| 3 | Remove station from route\n| 4 | Get list of stations in route\n" +
          "| 0 | Back\nSelect from Routes menu: "

    case gets.chomp
    when '1'
      @stations_to_add = []
      create_route_menu
    when '2'
      add_station_in_route_menu
    when '3'
      remove_station_from_route
    when '4'
      stations_in_route_menu
    when '0'
      main_menu
    else
      puts 'Wrong choice'
      routes_menu
    end
  end

  def trains_menu
    print "| 1 | Create train\n| 2 | Assign route\n| 3 | Move train by route\n" +
          "| 4 | Add/Remove railcars to/from train\n| 0 | Back\nSelect from Trains menu: "

    case gets.chomp
    when '1'
      create_train_menu
    when '2'
      assign_route_menu
    when '3'
      move_train_menu
    when '4'
      add_remove_railcars_menu
    when '0'
      main_menu
    else
      puts 'Wrong choice'
      trains_menu
    end
  end

  def create_route_menu
    puts '| 99 | Accept'
    choose_station_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@stations.size)
      @stations_to_add << @stations[menu_item - 1]
      puts @stations_to_add.join(' | ')
      create_route_menu
    when 99
      routes_menu unless @stations_to_add.size > 1
      @routes << Route.new(@stations_to_add)
      routes_menu
    when 0
      routes_menu
    else
      puts 'Wrong choice'
      create_route_menu
    end
  end

  def stations_in_route_menu
    choose_route_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@routes.size)
      puts @routes[menu_item - 1].stations_name.join(' | ')
      stations_in_route_menu
    when 0
      routes_menu
    else
      puts 'Wrong choice'
      stations_in_route_menu
    end
  end

  def add_station_in_route_menu
    choose_route_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@routes.size)
      choose_station_menu

      menu_item2 = gets.chomp.to_i
      case menu_item2
      when (1..@stations.size)
        @routes[menu_item - 1].add_station(@stations[menu_item2 - 1])
      else
        puts 'Wrong choice'
      end
      add_station_in_route_menu
    when 0
      routes_menu
    else
      puts 'Wrong choice'
      add_station_in_route_menu
    end
  end

  def remove_station_from_route
    choose_route_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@routes.size)
      puts 'Choose station to remove:'
      @routes[menu_item - 1].stations_name.each_with_index { |st, i| puts "| #{i + 1} | #{st}" }
      puts '| 0 | Back'

      menu_item2 = gets.chomp.to_i
      case menu_item2
      when (1..@routes[menu_item - 1].stations.size)
        @routes[menu_item - 1].delete_station(@routes[menu_item - 1]
          .stations[menu_item2 - 1])
      else
        puts 'Nothing have been choosed'
      end
      remove_station_from_route
    when 0
      routes_menu
    else
      puts 'Wrong choice'
      remove_station_from_route
    end
  end

  def create_train_menu
    print "| 1 | Passenger train\n| 2 | Cargo train\n| 0 | Back\nSelect type of train: "

    case gets.chomp
    when '1'
      print 'Enter number of train: '
      @trains << PassengerTrain.new(gets.chomp)
      puts @trains.map(&:number).join(' | ')
      trains_menu
    when '2'
      print 'Enter number of train: '
      @trains << CargoTrain.new(gets.chomp)
      puts @trains.map(&:number).join(' | ')
      trains_menu
    when '0'
      trains_menu
    else
      create_train_menu
    end
  end

  def assign_route_menu
    choose_train_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@trains.size)
      choose_route_menu

      menu_item2 = gets.chomp.to_i
      case menu_item2
      when (1..@routes.size)
        @trains[menu_item - 1].accept_route(@routes[menu_item2 - 1])
      else
        puts 'Wrong choice'
      end
      assign_route_menu
    when 0
      trains_menu
    else
      puts 'Wrong choice'
      assign_route_menu
    end
  end

  def move_train_menu
    choose_train_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@trains.size)
      print "| 1 | Forward\n| 2 | Backward\nSelect direction: "

      menu_item2 = gets.chomp
      case menu_item2
      when '1'
        @trains[menu_item - 1].travel_forward
      when '2'
        @trains[menu_item - 1].travel_backward
      else
        puts 'Wrong choice'
      end
      puts "Previous station: #{@trains[menu_item - 1].previous_station}\n" +
           "Current station: #{@trains[menu_item - 1].current_station}\n" +
           "Next station: #{@trains[menu_item - 1].next_station}"
      move_train_menu
    when 0
      trains_menu
    else
      puts 'Wrong choice'
      move_train_menu
    end
  end

  def add_remove_railcars_menu
    choose_train_menu
    menu_item = gets.chomp.to_i

    case menu_item
    when (1..@trains.size)
      puts "| 1 | Attach passenger car\n| 2 | Attach cargo car\n| 3 | Detach car\n| 0 | Back"
      menu_item2 = gets.chomp

      case menu_item2
      when '1'
        attach_passenger_car(menu_item - 1)
        trains_menu
      when '2'
        attach_cargo_car(menu_item - 1)
        trains_menu
      when '3'
        detach_car(menu_item - 1)
        trains_menu
      else
        puts 'Wrong choice'
        add_remove_railcars_menu
      end
    when 0
      trains_menu
    else
      puts 'Wrong choice'
      add_remove_railcars_menu
    end
  end

  def choose_route_menu
    @routes.each_with_index do |route, i|
      puts "| #{i + 1} | From #{route.stations_name.first} " +
           "to #{route.stations_name.last}"
    end
    print "| 0 | Back\nChoose route: "
  end

  def choose_station_menu
    @stations.each_with_index { |st, i| puts "| #{i + 1} | #{st}" }
    print "| 0 | Back\nChoose station: "
  end

  def choose_train_menu
    @trains.each_with_index { |tr, i| puts "| #{i + 1} | #{tr.number} #{tr.type}" }
    print "| 0 | Back\nChoose train: "
  end

  def attach_passenger_car(train_index)
    return unless @trains[train_index].type == 'Passenger'

    print 'Enter number of seats: '
    seats_amount = gets.chomp.to_i
    print 'Enter number of cars: '
    gets.chomp.to_i.times do
      @trains[train_index].attach_car(PassengerCar.new(seats_amount))
    end
    puts "Number of cars: #{@trains[train_index].cars_amount}"
  end

  def attach_cargo_car(train_index)
    return unless @trains[train_index].type == 'Cargo'

    print 'Enter volume: '
    volume = gets.chomp.to_i
    print 'Enter number of cars: '
    gets.chomp.to_i.times do
      @trains[train_index].attach_car(CargoCar.new(volume))
    end
    puts "Number of cars: #{@trains[train_index].cars_amount}"
  end

  def detach_car(train_index)
    @trains[train_index].detach_car
    puts "Number of cars: #{@trains[train_index].cars_amount}"
  end
end
