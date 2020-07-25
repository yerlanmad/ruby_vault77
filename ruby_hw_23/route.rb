# frozen_string_literal: true

class Route
  include Validatable
  include Logable

  @@routes = {}

  def self.all
    @@routes
  end

  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = "#{first_station.name}_#{last_station.name}"
    validate

    @@routes[self] = stations if valid?
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

  private

  def validate
    super(stations)
    super(name)
  rescue AttributeSizeError, AttributePresentError => e
    write_error(e.message)
    self.valid = false
  else
    self.valid = true
  end
end
