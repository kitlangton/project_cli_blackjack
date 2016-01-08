require 'player'
require 'deck'

# The main game class
class Blackjack
  attr_accessor :players, :deck

  def initialize(players: nil, deck: nil)
    @players = []
    @deck = deck || Deck.new
    @deck.shuffle
  end

  def play
    display_welcome
    ask_for_number_of_players
    initial_deal
    until game_over?
      display_game_state
      current_player.get_move
      next_player if current_player.done?
    end
    display_winner
  end

  def ask_for_number_of_players
    number = gets.chomp.to_i
    number == 0 ? ask_for_number_of_players : number
  end

  def game_over?
    players.all?(&:done?)
  end

  def display_welcome
    puts "Welcome to Blackjack!"
  end

  def initial_deal
    players.each do |player|
      2.times { deal(player) }
    end
  end

  def deal(player)
    player.add_card(deck.take_card)
  end
end
