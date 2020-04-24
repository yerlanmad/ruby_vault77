# frozen_string_literal: true

# Player class
class Player
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def hand=(card)
    @hand << card
  end

  def hand_clear
    @hand = []
  end
end
