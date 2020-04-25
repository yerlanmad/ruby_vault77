class Car
  def initialize
    @speed = 0
    @number = ''
  end

  def start_engine
    puts "Wroom"
  end

  def beep
    puts "Beep Beep"
  end

  def go
    @speed = 40
  end

  def stop
    @speed = 0
  end

  def current_speed
    @speed
  end
end
