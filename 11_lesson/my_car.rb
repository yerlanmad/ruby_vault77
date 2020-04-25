# my_car.rb

module HighLoadable
  def load_cargo(mass)
    "#{mass} tonns loaded"
  end
end

class Vechicle
  attr_accessor :color
  attr_reader :year, :model
  @@number_of_vechiles = 0

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vechiles += 1
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are going #{@current_speed} mph."
  end

  def shut_down
    puts "Let's park this beaty!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks greate!"
  end

  def self.calculate_gas_mileage(galons, miles)
    puts "#{miles / galons} miles per galon of gas"
  end

  private

  def calculate_age_of_vechicle
    Time.now.year - self.year
  end
end

class MyCar < Vechicle

  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}, #{calculate_age_of_vechicle} age old"
  end
end

class MyTruck < Vechicle
  include HighLoadable

  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{self.color}, #{self.year}, #{self.model}"
  end
end
