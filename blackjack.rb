# Card
# Suit
# Rank

require "highline"

SUITS = %W{ C D H S }
RANKS = %W{ A 2 3 4 5 6 7 8 9 T J Q K}

CLI = HighLine.new

class Card
	CARD_VALUES = {
		'A' => 11,
		'2' => 2,
		'3' => 3,
		'4' => 4,
		'5' => 5,
		'6' => 6,
		'7' => 7,
		'8' => 8,
		'9' => 9,
		'T' => 10,
		'J' => 10,
		'Q' => 10,
		'K' => 10
	}

	attr_reader :suit, :rank

	def initialize(suit, rank)
		@suit = suit
		@rank = rank
	end

	def to_s
		"#{rank}#{suit}"
	end

	def card_value
		CARD_VALUES[rank]
	end

	def inspect
		"#{rank}#{suit}"
	end
end

class Deck

	attr_accessor :cards

	def initialize
		@cards = []
	end

	def self.build
		deck = self.new
		SUITS.each do |suit|
			RANKS.each do |rank|
				deck.cards << Card.new(suit, rank)
			end
		end
		deck.shuffle
	end

	def shuffle
		@cards.shuffle!
		self
	end

	def draw
		@cards.pop
	end
end

class Hand
	HAND_STATUS = %W{ Bust Live Pat }

	attr_accessor :cards, :status

	def initialize
		@cards = []
		@status = "Live"
	end

	def add_card(card)
		@cards << card
	end

	def to_s
		@cards.to_s
	end

	def hand_value
		@cards.inject(0) { |sum, card| sum += card.card_value}
	end
end

class Deal
	attr_accessor :player_hand, :house_hand, :deck

	def initialize
		@player_hand = Hand.new
		@house_hand = Hand.new
		@deck = Deck.build
	end

	def initial_deal
		player_hand.add_card(deck.draw)
		player_hand.add_card(deck.draw)
		player_hand.status = "Live"

		house_hand.add_card(deck.draw)
		house_hand.add_card(deck.draw)
		house_hand.status = "Live"
	end

	# def deal
	# 	player_hand.add_card(deck.draw)
	# 	house_hand.add_card(deck.draw)
	# end

	def play_player_hand
		while player_hand.status == "Live"
			player_action = get_player_move
			self.send player_action, player_hand
		end
	end

	def get_player_move
		loop do
			input = CLI.ask "hit or stand?"
			case input.downcase
			when /hit/
				return :hit
			when /stand/
				return :stand
			else
				"need answer"
				next
			end
		end
	end

	def play_house_hand
		while @house_hand.value < 17
			hit(house_hand)
		end

		if house_hand.value <= 21
			house_hand.status = "Pat"
		end
	end

	def hit(hand)
		hand.add_card(deck.draw)
		puts "has been called"
		puts hand

		if hand.hand_value > 21
			hand.status = "Bust"
		end
	end

	def stand (hand)
		hand.status = "Pat"
	end

	def double_down
	end

	def split_pair
	end

	def display
		puts "Player Hand:"
		puts @player_hand.display
		puts @player_hand.hand_value
		puts "House Hand:"
		puts @house_hand.display
		puts @house_hand.hand_value
	end
end

deal = Deal.new
deal.initial_deal
deal.display
deal.play_player_hand



deal.display



