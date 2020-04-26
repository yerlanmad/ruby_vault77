class Route
  @@routes = {}
  # создать метод класса all, который возвращает хэш,
  # в котором ключом будет являться каждый созданный на данный момент маршрут,
  # а значением к нему - массив станций, из которых состоит этот маршрут

  def self.all
    @@routes
  end

  attr_reader :stations

  # Может иметь промежуточные станции между начальной и конечной
  def initialize(args)
    @stations = args
    @@routes[self] = stations
  end

  # Может добавлять промежуточную станцию в список (станция должна быть
  # именно промежуточной, нельзя менять первую и конечную станции)
  def add_station(station)
    return if stations.include?(station)

    @stations.insert(1, station)
  end

  # Может удалять промежуточную станцию из списка
  # (нельзя удалять первую и конечную станции)
  def delete_station(station)
    return until stations[1...-1].include?(station)

    @stations.delete(station)
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def get_stations
    stations.map(&:to_s)
  end
end
