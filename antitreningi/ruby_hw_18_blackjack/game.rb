# frozen_string_literal: true

# Game class
class Game
  attr_reader :scoresheet, :deck
  attr_accessor :player_score, :dealer_score

  include PlayingCards

  def initialize(deck_count)
    @scoresheet = blackjack_scoresheet
    @dealer = Dealer.new('Dealer', self)
    @deck = Deck.new(deck_count)
    start_game
  end

  private

  def start_game
    system 'clear'
    print 'Enter your name: '
    @player = Player.new(gets.chomp)
    start_round
  end

  def start_round
    @player_score = 0
    @dealer_score = 0
    @player.hand_clear
    @dealer.hand_clear
    show_table
    main_menu
  end

  def show_table
    system 'clear'
    puts "#{@deck.cards_in_deck} cards in deck"
    puts "#{@player.name}, (#{player_score})"
    puts "| #{@player.hand.join(' | ')} |"
    puts @dealer.name.to_s
    puts "| #{@dealer.hand.map { '*' }.join(' | ')} |"
  end

  def main_menu
    puts 'Your action:'
    puts '| 1 | Stand'
    puts '| 2 | Hit'
    puts '| 3 | Open cards'

    case gets.chomp
    when '1'
      @dealer.move
      show_table
      main_menu
    when '2'
      @dealer.deal(@player)
      show_table
      main_menu
    when '3'
      show_score
    else
      puts 'Whrong choice'
      main_menu
    end
  end

  def show_score
    puts "#{@player.name}, (#{player_score}), | #{@player.hand.join(' | ')} |"
    puts "#{@dealer.name}, (#{dealer_score}), | #{@dealer.hand.join(' | ')} |"
    if_player_win
    puts 'Again? (Y/N)'
    start_round if gets.chomp == 'Y'
  end

  def if_player_win
    if player_score < 22 && (player_score > dealer_score || dealer_score > 21)
      puts 'You win'
    elsif player_score == dealer_score
      puts 'Draw'
    else
      puts 'Dealer win'
    end
  end
end
