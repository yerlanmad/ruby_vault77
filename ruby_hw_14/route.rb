class Route
  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = "#{first_station.name}_#{last_station.name}"
  end

  def add_station(station)
    return if stations.include?(station)

    stations.insert(-2, station)
  end

  def delete_station(station)
    return if [0, -1].any? { |i| stations[i] == station }

    stations.delete(station)
  end

  def stations_name
    stations.map(&:name)
  end
end
