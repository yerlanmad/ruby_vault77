# frozen_string_literal: true

# Deck class
class Deck
  include PlayingCards

  def initialize(cnt = 1)
    # limit counts of deck
    @deck = (2..8).include?(cnt) ? (new_deck * cnt).shuffle : new_deck.shuffle
  end

  def shuffle_deck
    @deck.shuffle!
  end

  def deal_card
    @deck.shift
  end

  def cards_in_deck
    @deck.count
  end
end
