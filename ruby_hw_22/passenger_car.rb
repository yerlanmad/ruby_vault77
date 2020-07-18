# frozen_string_literal: true

require_relative 'rail_car'

class PassengerCar < RailCar
  attr_reader :seats_amount, :type, :occupied_seats

  def initialize(seats)
    @seats_amount = seats
    @type = 'Passenger'
    @occupied_seats = 0
    validate
    write_log("#{type}, seats amount: #{seats_amount}")
  rescue AttributeSizeError, AttributePresentError => e
    write_error(e.message)
  end

  def take_place
    self.occupied_seats += 1 if occupied_seats < seats_amount
  end

  def empty_seats
    seats_amount - occupied_seats
  end

  private

  attr_writer :occupied_seats

  def validate
    super(seats_amount)
    raise AttributeSizeError unless (15..70).include?(seats_amount)
  end
end
