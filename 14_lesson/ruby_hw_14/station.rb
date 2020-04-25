class Station
  attr_reader :station_name

  def initialize(name)
    @station_name = name
    @trains = []
  end

  # Может принимать поезда (объекты класса Train, по одному за раз)
  def accept_train(train)
    @trains.push(train)
  end

  # Может возвращать список всех поездов на станции
  # Может возвращать список поездов на станции по типу (см. ниже):
  # должен вернуть поезда определенного типа, находящихся на станции.
  def get_trains(type = "all")
    if type == "all"
      @trains.each { |el| p el.train_number }
    else
      @trains.select { |el| el.train_type == type  }.each { |el| p el.train_number }
    end
  end

  # Может отправлять поезда на другие станции маршрута (по одному за раз,
  # при этом, поезд удаляется из списка поездов, находящихся на станции)
  def send_train(train, station_name)
    station_name.accept_train(train)
    @trains.delete(train)
  end
end
