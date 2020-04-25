class Viking
  @@instances = 0
  def initialize(name, health, age, strength)
    @name = name
    @health = health
    @age = age
    @strength = strength
    @@instances += 1
  end

  class << self
    def create_warrior(name)
      age = rand * 20 + 15
      health = [age * 5, 120].min
      strength = [age / 2, 10].min
      Viking.new(name, health, age, strength)
    end

    def random_name
      ["Erik", "Lars", "Leif"].sample
    end

    def silver_to_gold(silver_pieces)
      silver_pieces / 10
    end

    def gold_to_silver(gold_pieces)
      gold_pieces * 10
    end
  end
end
