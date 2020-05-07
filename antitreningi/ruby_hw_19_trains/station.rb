class Station
  @@stations = []
  # метод класса all, который возвращает все станции (объекты),
  # созданные на данный момент
  def self.all
    @@stations
  end

  def initialize(**opts)
    @station_name = opts[:name]
    @trains = opts[:trains] || []
    @@stations << self
  end

  def to_s
    @station_name
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
  def get_trains(type = 'all')
    if type == 'all'
      @trains
    else
      @trains.select { |el| el.train_type == type }
    end
  end

  private

  # Может отправлять поезда на другие станции маршрута (по одному за раз,
  # при этом, поезд удаляется из списка поездов, находящихся на станции)
  def send_train(train, station)
    station.accept_train(train)
    remove_train(train)
  end
end
