class Team
  include Enumerable

  attr_accessor :name, :players
  def initialize(name)
    @name = name
    @players = []
  end

  def initialize(name)
    @name = name
    @players = []
  end

  def add_players(*players)
    @players += players
  end

  def to_s
    "#{@name} team: #{@players.join(", ")}"
  end

  def each { |player| yeild player }
  end
end

require_relative 'player'
require_relative 'team'

player1 = Player.new("Bob", 13, 5)
player2 = Player.new("Jim", 15, 4.5)
player3 = Player.new("Mike", 21, 5)
player4 = Player.new("Joe", 14, 5)
player5 = Player.new("Scott", 16, 3)

red_team = Team.new("Read team")
red_team.add_players(player1, player2, plaers3, player4, player5)

elig_players = red_team.select {|player| (14..20) === player.age }
                .reject {|player| player.skill_leverl <= 4.5}
                
puts elig_players
