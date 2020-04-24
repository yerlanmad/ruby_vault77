# frozen_string_literal: true

# Dealer class
class Dealer < Player
  # Dealer's move
  def move(game)
    deal(self, game) if game.hand_score(self) < 17
  end

  # Dealing card
  def deal(player, game)
    return until player.cards_in_hand < 3 && game.hand_score(player) < 21

    player.hand = game.deal_card
  end
end
