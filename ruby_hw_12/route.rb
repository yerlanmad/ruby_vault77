class Route
  # Может выводить список всех станций по-порядку от начальной до конечной
  attr_reader :stations, :name

  # Может иметь промежуточные станции между начальной и конечной
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = "#{first_station.name}_#{last_station.name}"
  end

  # Может добавлять промежуточную станцию в список (станция должна быть
  # именно промежуточной, нельзя менять первую и конечную станции)
  def add_station(station)
    return if stations.include?(station)

    @stations.insert(-2, station)
  end

  # Может удалять промежуточную станцию из списка
  # (нельзя удалять первую и конечную станции)
  def delete_station(station)
    return if [0, -1].any? { |i| stations[i] == station }

    @stations.delete(station)
  end
end
