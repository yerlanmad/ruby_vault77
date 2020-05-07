class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def to_s
    name
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
  def get_trains(type = "all")
    if type == "all"
      @trains
    else
      @trains.select { |el| el.type == type }
    end
  end

  # Может отправлять поезда на другие станции маршрута (по одному за раз,
  # при этом, поезд удаляется из списка поездов, находящихся на станции)
  def send_train(train, station)
    station.accept_train(train)
    remove_train(train)
  end
end
