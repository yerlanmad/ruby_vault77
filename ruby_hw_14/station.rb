class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  # Может принимать поезда (объекты класса Train, по одному за раз)
  def accept_train(train)
    @trains << train
  end

  def remove_train(train)
    @trains.delete(train)
  end

  # Может возвращать список всех поездов на станции
  # Может возвращать список поездов на станции по типу (см. ниже):
  # должен вернуть поезда определенного типа, находящихся на станции.
  def trains(type = nil)
    return @trains unless type

    @trains.select { |train| train.type == type }
  end

  # Может отправлять поезда на другие станции маршрута (по одному за раз,
  # при этом, поезд удаляется из списка поездов, находящихся на станции)
  def send_train(train, station)
    remove_train(train)
    station.accept_train(train)
  end
end
