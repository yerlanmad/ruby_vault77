# frozen_string_literal: true

# Dealer class
class Dealer < Player
  def initialize(name, game)
    super(name)
    @game = game
  end

  # Dealer's move
  def move
    deal(self) if @game.dealer_score < 17
  end

  # Dealing cards
  def deal(player)
    return until player.hand.length < 3
    # find way not to use #shift to deal cards
    player.hand = @game.deck.deal_card
    if player == self
      @game.dealer_score = count_score(player)
    else
      @game.player_score = count_score(player)
    end
  end

  private

  def count_score(player)
    score = player.hand.inject(0) { |sum, card| sum + @game.scoresheet[card] }
    player.hand.map { |c| c.include?('A') }.count(true).times do
      score -= 10 if score > 21
    end
    score
  end
end
