# frozen_string_literal: true

require_relative 'rail_car'

class PassengerCar < RailCar
  attr_reader :seats_amount

  def initialize(seats)
    @seats_amount = seats
    @type = 'Passenger'
    validate
  end

  def validate
    super(seats_amount)
    raise AttributeSizeError unless (15..70).include?(seats_amount)
  end
end
