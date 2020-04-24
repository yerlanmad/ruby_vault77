# frozen_string_literal: true

# Game class
class Game
  include PlayingCards

  def initialize
    @scoresheet = blackjack_scoresheet
  end

  def start_game
    system 'clear'
    print 'Enter your name: '
    @player = Player.new(gets.chomp)
    print "Enter number of decks: "
    @deck = Deck.new(gets.chomp.to_i)
    @dealer = Dealer.new('Dealer')
    start_round
  end

  def deal_card
    @deck.deal_card
  end

  def hand_score(player)
    score = player.hand.reduce(0) { |sum, card| sum + @scoresheet[card] }
    player.hand.select { |c| c.include?('A') }.each { score -= 10 if score > 21 }
    score
  end

  private

  # Scoresheet for Blackjack, key = card, value = score
  def blackjack_scoresheet
    scoresheet = {}
    suits.each do |s|
      ranks.each do |r|
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

  def start_round
    return until @deck.cards_in_deck > 5

    @information = "Round Started"
    @player.hand_clear
    @dealer.hand_clear
    puts show_table
    main_menu
  end

  def show_table
    system 'clear'
    "#{@deck.cards_in_deck} cards in deck | #{@information}\n" +
      "#{@player.name}, (#{hand_score(@player)})\n" +
      "| #{@player.hand.join(' | ')} |\n" +
      "#{@dealer.name}\n" +
      "| #{@dealer.hand.map { '*' }.join(' | ')} |"
  end

  def main_menu
    puts "Your action:\n| 1 | Stand\n| 2 | Hit\n| 3 | Open cards"
    case gets.chomp
    when '1'
      stand
    when '2'
      hit
    when '3'
      stop_round
    else
      wrong_choise
    end
  end

  def stand
    @dealer.move(self)
    @information = "Stand, Dealer's move"
    puts show_table
    main_menu
  end

  def hit
    @dealer.deal(@player, self)
    @information = "Hit"
    puts show_table
    main_menu
  end

  def stop_round
    @information = "Round ended"
    puts show_table
    puts show_score
    puts winner
    puts 'Again? (Y/N)'
    start_round if gets.chomp.upcase == 'Y'
  end

  def wrong_choise
    @information = 'Whrong choice'
    puts show_table
    main_menu
  end

  def show_score
    "#{@player.name}, (#{hand_score(@player)}), | #{@player.hand.join(' | ')} |\n" +
      "#{@dealer.name}, (#{hand_score(@dealer)}), | #{@dealer.hand.join(' | ')} |"
  end

  def winner
    if hand_score(@player) < 22 && (hand_score(@player) > hand_score(@dealer) || hand_score(@dealer) > 21)
      'You win'
    elsif hand_score(@player) == hand_score(@dealer)
      'Draw'
    else
      'Dealer win'
    end
  end
end
