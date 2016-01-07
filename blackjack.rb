# Card
# Suit
# Rank

require "highline"

SUITS = %W{ C D H S }
RANKS = %W{ A 2 3 4 5 6 7 8 9 T J Q K}

CLI = HighLine.new

class Card
	CARD_VALUES = {
		'A' => 1,
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
	include Comparable
	HAND_STATUS = %W{ Bust Live Pat }

	attr_accessor :cards, :status

	def initialize
		@cards = []
		@status = "Live"
	end

	def add_card(card)
		@cards << card
	end

	def display
		puts "Cards: #{cards}"
		puts "Value: #{hand_value}"
	end

	def soft_seventeen? 
		total = 0
		@cards.each do |card| 
			total += card.card_value
		end
		total == 7 && number_of_aces >= 1
	end

	def hand_value
		total = 0
		@cards.each do |card| 
			total += card.card_value
		end

		number_of_aces.times do
			if total <= 11
				total += 10
			end
		end

		total
	end

	def number_of_aces
		@cards.select { |card| card.rank == "A"}.count
	end

	def <=>(other_hand)
		hand_value <=> other_hand.hand_value
	end
end

class Deal
	GAME_RESULTS = [ "Player Wins", "House Wins", "Push" ]

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

	def game_cycle
		initial_deal
		display
		play_player_hand

		play_house_hand if player_hand.status != "Bust"
		puts check_for_winner
	end

	def check_for_winner
		@result = "No Winner"
		if game_over
			if player_hand > house_hand
				@result = "Player Wins"
			elsif house_hand > player_hand
				@result = "House Wins"
			elsif house_hand == player_hand
				@result = "Push"
			end
		else
			@result = "House Wins" if player_hand.status == "Bust"
			@result = "Player Wins" if house_hand.status == "Bust"
		end
		@result
	end

	def game_over
		player_hand.status == "Pat" && house_hand.status == "Pat"
	end

	def play_player_hand
		while player_hand.status == "Live"
			player_action = get_player_move
			self.send player_action, player_hand
			puts "You #{player_action.to_s} and your hand is:"
			puts player_hand.display
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
		while @house_hand.hand_value < 17 || house_hand.soft_seventeen?
			hit(house_hand)
			puts "The house hits!"
			puts house_hand.display
		end

		if house_hand.hand_value <= 21
			house_hand.status = "Pat"
		end
	end

	def hit(hand)
		hand.add_card(deck.draw)

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
		puts "House Hand:"
		puts @house_hand.display
	end
end

deal = Deal.new
deal.game_cycle
