# frozen_string_literal: true

# class App
class App
  def initialize
    @stations = []
    @routes = []
    @trains = []
    @stations_to_add = []
    main_menu
  end

  private

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

  def stations_menu
    print "| 1 | Create station\n| 2 | Get list of trains\n| 0 | Back\nSelect from Stations menu: "

    case gets.chomp
    when '1'
      print 'Enter name of station: '
      @stations << Station.new(gets.chomp)
      puts @stations.join(' | ')
      stations_menu
    when '2'
      choose_station_menu

      menu_item = gets.chomp.to_i
      case menu_item
      when (1..@stations.size)
        @stations[menu_item - 1].get_trains
        stations_menu
      when '0'
        stations_menu
      else
        puts 'Wrong choice'
        stations_menu
      end
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
    choose_station_menu
    puts '| 99 | Accept'

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@stations.size)
      @stations_to_add << @stations[menu_item - 1]
      puts @stations_to_add.join(' | ')
      create_route_menu
    when 99
      routes_menu until @stations_to_add.size > 1
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
      puts @routes[menu_item - 1].get_stations.join(' | ')
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
        add_station_in_route_menu
      when 0
        add_station_in_route_menu
      else
        puts 'Wrong choice'
        add_station_in_route_menu
      end
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
      puts 'Chose stations:'
      @routes[menu_item - 1].get_stations.each_with_index do |st, i|
        puts "| #{i + 1} | #{st}"
      end
      puts '| 0 | Back'

      menu_item2 = gets.chomp.to_i
      case menu_item2
      when (1..@routes[menu_item - 1].stations.size)
        @routes[menu_item - 1].delete_station(@routes[menu_item - 1]
          .stations[menu_item2 - 1])
        remove_station_from_route
      when 0
        remove_station_from_route
      else
        puts 'Wrong choice'
        remove_station_from_route
      end
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

      puts @trains.map(&:train_number).join(' | ')
      puts @trains.map(&:all_instances).join(' | ')
      trains_menu
    when '2'
      print 'Enter number of train: '
      @trains << CargoTrain.new(gets.chomp)
      puts @trains.map(&:train_number).join(' | ')
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
        assign_route_menu
      when 0
        assign_route_menu
      else
        puts 'Wrong choice'
        assign_route_menu
      end
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
      puts "Previous: #{@trains[menu_item - 1].previous_station}\n" +
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
      puts "| 1 | Attach car\n| 2 | Detach car\n| 0 | Back"
      menu_item2 = gets.chomp

      case
      when menu_item2 == '1' && @trains[menu_item - 1].train_type == 'Passenger'
        print 'Enter number of seats: '
        num_of_seats = gets.chomp.to_i
        print 'Enter number of cars: '
        gets.chomp.to_i.times do
          @trains[menu_item - 1].attach_car(PassengerCar.new(num_of_seats))
        end
        puts "Number of cars: #{@trains[menu_item - 1].rail_cars.size}"
        trains_menu
      when menu_item2 == '1' && @trains[menu_item - 1].train_type == 'Cargo'
        print 'Enter load mass: '
        load_mass = gets.chomp.to_i
        print 'Enter number of cars: '
        gets.chomp.to_i.times do
          @trains[menu_item - 1].attach_car(FreightCar.new(load_mass))
        end
        puts "Number of cars: #{@trains[menu_item - 1].rail_cars.size}"
        trains_menu
      when menu_item2 == '2'
        @trains[menu_item - 1].detach_car
        puts "Number of cars: #{@trains[menu_item - 1].rail_cars.size}"
        trains_menu
      when menu_item2 == '0'
        add_remove_railcars_menu
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
    puts 'Choose route:'
    @routes.each_with_index do |route, i|
      puts "| #{i + 1} | From #{route.get_stations.first} " +
           "to #{route.get_stations.last}"
    end
    puts "| 0 | Back"
  end

  def choose_station_menu
    puts 'Choose station:'
    @stations.each_with_index { |st, i| puts "| #{i + 1} | #{st}" }
    puts '| 0 | Back'
  end

  def choose_train_menu
    puts 'Choose train:'
    @trains.each_with_index { |tr, i| puts "| #{i + 1} | #{tr.train_number} #{tr.train_type}" }
    puts '| 0 | Back'
  end
end
