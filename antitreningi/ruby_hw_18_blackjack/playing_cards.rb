# frozen_string_literal: true

# Module Playing Cards
module PlayingCards
  # card ranks
  RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2].freeze
  # card suits
  SUITS = ["\u2665", "\u2666", "\u2663", "\u2660"].freeze

  private

  # Scoresheet for Blackjack, key = card, value = score
  def blackjack_scoresheet
    scoresheet = {}
    SUITS.each do |s|
      RANKS.each do |r|
        case r
        when 'A'
          scoresheet["#{r}#{s}"] = 11
        when 'K', 'Q', 'J'
          scoresheet["#{r}#{s}"] = 10
        else
          scoresheet["#{r}#{s}"] = r.to_i
        end
      end
    end
    scoresheet
  end

  # Create new deck of cards
  def new_deck
    SUITS.map { |s| RANKS.map { |r| r + s } }.flatten
  end
end
