# frozen_string_literal: true

# Module Playing Cards
module PlayingCards
  private

  # card ranks
  def ranks
    %w[A K Q J 10 9 8 7 6 5 4 3 2]
  end

  # card suits
  def suits
    ["\u2665", "\u2666", "\u2663", "\u2660"]
  end
end
