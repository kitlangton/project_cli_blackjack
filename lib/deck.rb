require 'card'

class Deck
  SUITS = [:spades, :hearts, :diamonds, :clubs]
  RANKS = [:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king]

  attr_reader :cards

	def initialize
    @cards = build_deck
	end

  def build_deck
    array = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        array << Card.new(rank, suit)
      end
    end
    array
  end

  def shuffle
    @cards = cards.shuffle
    self
  end

  def take_card
    @cards.pop
  end
end
