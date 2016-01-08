class Player
  attr_accessor :hand, :status

  def initialize
    @hand = nil
    @status = nil
  end

  def get_move
    puts "Hit or Stand?"
    move = gets.chomp.downcase.to_sym
    return get_move unless move == :hit || move == :stand
    move
  end

  def add_card(card)
    hand << card
  end

  def done?
    @status == :bust || @status == :stand
  end

  def display_hand
    hand.display_cards
  end
end
