class Route
  attr_reader :stations

  # Может иметь промежуточные станции между начальной и конечной
  def initialize(args)
    @stations = args
  end

  # Может добавлять промежуточную станцию в список (станция должна быть
  # именно промежуточной, нельзя менять первую и конечную станции)
  def add_station(station)
    return if self.stations.include?(station)
    @stations.insert(1, station)
  end

  # Может удалять промежуточную станцию из списка
  # (нельзя удалять первую и конечную станции)
  def delete_station(station)
    return until self.stations[1...-1].include?(station)
    @stations.delete(station)
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def get_stations
    self.stations.map { |st| st.station_name }.join(" | ")
  end

end
