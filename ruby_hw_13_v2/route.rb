class Route
  attr_reader :stations, :name

  # Может иметь промежуточные станции между начальной и конечной
  def initialize(*args)
    @stations = args
    @name = args.join("_")
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
    stations
  end
end