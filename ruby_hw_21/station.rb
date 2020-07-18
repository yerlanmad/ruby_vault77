# frozen_string_literal: true

class Station
  include Validator

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    validate(name)

    @@stations << self
  end

  def accept_train(train)
    @trains << train
  end

  def remove_train(train)
    @trains.delete(train)
  end

  def trains(type = nil)
    return @trains unless type

    @trains.select { |train| train.type == type }
  end

  def trains_name
    @trains.map(&:name).join(', ')
  end

  def send_train(train, station)
    remove_train(train)
    station.accept_train(train)
  end

  def each_train
    return unless block_given?

    trains.each do |train|
      yield(train)
    end
  end
end
