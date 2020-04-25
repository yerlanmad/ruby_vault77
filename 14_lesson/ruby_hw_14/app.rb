class App

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @stations_to_add = []
    self.main_menu
  end

  private
  def main_menu
    puts "Select from Main menu: "
    puts "| 1 | Stations"
    puts "| 2 | Routes"
    puts "| 3 | Trains"
    puts "| 0 | Exit"

    case gets.chomp
    when "1"
      self.stations_menu
    when "2"
      self.routes_menu
    when "3"
      self.trains_menu
    when "0"
      puts "Good bye"
    else
      puts "Wrong choice"
      self.main_menu
    end
  end

  def stations_menu
    puts "Select from Stations menu: "
    puts "| 1 | Create station"
    puts "| 2 | Get list of trains"
    puts "| 0 | Back"

    case gets.chomp
    when "1"
      print "Enter name of station: "
      @stations << Station.new(gets.chomp)
      puts @stations.map {|st| st.station_name}.join(" | ")
      self.stations_menu
    when "2"
      self.choose_station_menu

      menu_item = gets.chomp.to_i
      case menu_item
      when (1..@stations.length)
        @stations[menu_item-1].get_trains
        self.stations_menu
      when "0"
        self.stations_menu
      else
        puts "Wrong choice"
        self.stations_menu
      end
    when "0"
      self.main_menu
    else
      puts "Wrong choice"
      self.stations_menu
    end
  end

  def routes_menu
    puts "Select from Routes menu: "
    puts "| 1 | Create route"
    puts "| 2 | Add station in route"
    puts "| 3 | Remove station from route"
    puts "| 4 | Get list of stations in route"
    puts "| 0 | Back"

    case gets.chomp
    when "1"
      @stations_to_add = []
      self.create_route_menu
    when "2"
      self.add_station_in_route_menu
    when "3"
      self.remove_station_from_route
    when "4"
      self.stations_in_route_menu
    when "0"
      self.main_menu
    else
      puts "Wrong choice"
      self.routes_menu
    end
  end

  def trains_menu
    puts "Select from Trains menu: "
    puts "| 1 | Create train"
    puts "| 2 | Assign route"
    puts "| 3 | Move train by route"
    puts "| 4 | Add/Remove railcars to/from train"
    puts "| 0 | Back"

    case gets.chomp
    when "1"
      self.create_train_menu
    when "2"
      self.assign_route_menu
    when "3"
      self.move_train_menu
    when "4"
      self.add_remove_railcars_menu
    when "0"
      self.main_menu
    else
      puts "Wrong choice"
      self.trains_menu
    end
  end

  def create_route_menu
    self.choose_station_menu
    puts "| 99 | Accept"

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@stations.length)
      @stations_to_add << @stations[menu_item-1]
      puts @stations_to_add.map {|st| st.station_name}.join(" | ")
      self.create_route_menu
    when 99
      self.routes_menu until @stations_to_add.length > 1
      @routes << Route.new(@stations_to_add)
      self.routes_menu
    when 0
      self.routes_menu
    else
      puts "Wrong choice"
      self.create_route_menu
    end
  end

  def stations_in_route_menu
    self.choose_route_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@routes.length)
      puts @routes[menu_item-1].get_stations
      self.stations_in_route_menu
    when 0
      self.routes_menu
    else
      puts "Wrong choice"
      self.stations_in_route_menu
    end
  end

  def add_station_in_route_menu
    self.choose_route_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@routes.length)
      self.choose_station_menu

      menu_item_2 = gets.chomp.to_i
      case menu_item_2
      when (1..@stations.length)
        @routes[menu_item-1].add_station(@stations[menu_item_2-1])
        self.add_station_in_route_menu
      when 0
        self.add_station_in_route_menu
      else
        puts "Wrong choice"
        self.add_station_in_route_menu
      end
    when 0
      self.routes_menu
    else
      puts "Wrong choice"
      self.add_station_in_route_menu
    end
  end

  def remove_station_from_route
    self.choose_route_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@routes.length)
      puts "Chose stations:"
      @routes[menu_item-1].stations.each.with_index { |st, i| puts "| #{i+1} | #{st.station_name}" }
      puts "| 0 | Back"

      menu_item_2 = gets.chomp.to_i
      case menu_item_2
      when (1..@routes[menu_item-1].stations.length)
        @routes[menu_item-1].delete_station(@routes[menu_item-1].stations[menu_item_2-1])
        self.remove_station_from_route
      when 0
        self.remove_station_from_route
      else
        puts "Wrong choice"
        self.remove_station_from_route
      end
    when 0
      self.routes_menu
    else
      puts "Wrong choice"
      self.remove_station_from_route
    end
  end

  def create_train_menu
    puts "Select type of train: "
    puts "| 1 | Passenger train"
    puts "| 2 | Cargo train"
    puts "| 0 | Back"

    case gets.chomp
    when "1"
      print "Enter number of train: "
      @trains << PassengerTrain.new(gets.chomp)
      puts @trains.map {|tr| tr.train_number}.join(" | ")
      self.trains_menu
    when "2"
      print "Enter number of train: "
      @trains << CargoTrain.new(gets.chomp)
      puts @trains.map {|tr| tr.train_number}.join(" | ")
      self.trains_menu
    when "0"
      self.trains_menu
    else
      self.create_train_menu
    end
  end

  def assign_route_menu
    self.choose_train_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@trains.length)
      self.choose_route_menu

      menu_item_2 = gets.chomp.to_i
      case menu_item_2
      when (1..@routes.length)
        @trains[menu_item-1].accept_route(@routes[menu_item_2-1])
        self.assign_route_menu
      when 0
        self.assign_route_menu
      else
        puts "Wrong choice"
        self.assign_route_menu
      end
    when 0
      self.trains_menu
    else
      puts "Wrong choice"
      self.assign_route_menu
    end
  end

  def move_train_menu
    self.choose_train_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@trains.length)
      puts "Select direction: "
      puts "| 1 | Forward"
      puts "| 2 | Backward"
      puts "| 0 | Back"

      menu_item_2 = gets.chomp
      case menu_item_2
      when "1"
        @trains[menu_item-1].move_train("fwd")
        puts "Current station: #{@trains[menu_item-1].get_station("current")}"
        puts "Next station: #{@trains[menu_item-1].get_station("next")}"
        puts "Previous: #{@trains[menu_item-1].get_station("previous")}"
        self.move_train_menu
      when "2"
        @trains[menu_item-1].move_train("backwd")
        puts "Current station: #{@trains[menu_item-1].get_station("current")}"
        puts "Next station: #{@trains[menu_item-1].get_station("next")}"
        puts "Previous: #{@trains[menu_item-1].get_station("previous")}"
        self.move_train_menu
      when "0"
        self.move_train_menu
      else
        puts "Wrong choice"
        self.move_train_menu
      end

    when 0
      self.trains_menu
    else
      puts "Wrong choice"
      self.move_train_menu
    end
  end

  def add_remove_railcars_menu
    self.choose_train_menu

    menu_item = gets.chomp.to_i
    case menu_item
    when (1..@trains.length)
      puts "| 1 | Attach car"
      puts "| 2 | Detach car"
      puts "| 0 | Back"

      menu_item_2 = gets.chomp
      case
      when menu_item_2 == "1" && @trains[menu_item-1].train_type == "Passenger"
        print "Enter number of seats: "
        num_of_seats = gets.chomp.to_i
        print "Enter number of cars: "
        gets.chomp.to_i.times do
          @trains[menu_item-1].attach_car(PassengerCar.new(num_of_seats))
        end
        puts "Number of cars: #{@trains[menu_item-1].rail_cars.length}"
        self.trains_menu
      when menu_item_2 == "1" && @trains[menu_item-1].train_type == "Cargo"
        print "Enter load mass: "
        load_mass = gets.chomp.to_i
        print "Enter number of cars: "
        gets.chomp.to_i.times do
          @trains[menu_item-1].attach_car(FreightCar.new(load_mass))
        end
        puts "Number of cars: #{@trains[menu_item-1].rail_cars.length}"
        self.trains_menu
      when menu_item_2 == "2"
        @trains[menu_item-1].detach_car
        puts "Number of cars: #{@trains[menu_item-1].rail_cars.length}"
        self.trains_menu
      when menu_item_2 == "0"
        self.add_remove_railcars_menu
      else
        puts "Wrong choice"
        self.add_remove_railcars_menu
      end

    when 0
      self.trains_menu
    else
      puts "Wrong choice"
      self.add_remove_railcars_menu
    end
  end

  def choose_route_menu
    puts "Choose route:"
    @routes.each.with_index do |route, i|
      puts "| #{i+1} | From #{route.stations.first.station_name} " +
            "to #{route.stations.last.station_name}"
    end
    puts "| 0 | Back"
  end

  def choose_station_menu
    puts "Choose station:"
    @stations.each.with_index { |st, i| puts "| #{i+1} | #{st.station_name}" }
    puts "| 0 | Back"
  end

  def choose_train_menu
    puts "Choose train:"
    @trains.each.with_index { |tr, i| puts "| #{i+1} | #{tr.train_number} #{tr.train_type}" }
    puts "| 0 | Back"
  end
end
