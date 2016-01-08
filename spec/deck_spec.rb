require 'deck'
require 'spec_helper'

describe 'deck' do

	let(:deck) { Deck.new }

	context 'a new deck' do
		it 'has 52 cards' do
			expect(deck.cards.size).to eq 52
		end

		it 'has 13 of each suit' do
      suits = [:spades, :hearts, :diamonds, :clubs]
      suits.each do |suit|
        count = deck.cards.select { |card| card.suit == suit }.count
        expect(count).to eq 13
      end
		end

		it 'has 4 of each rank' do
      ranks = [:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king]
      ranks.each do |rank|
        count = deck.cards.select { |card| card.rank == rank }.count
        expect(count).to eq 4
      end
		end
	end

  describe '#shuffle' do
    it 'shuffles the deck' do
      original_order = deck.cards
      deck.shuffle
      new_order = deck.cards
      expect(original_order).to_not eq new_order
    end
  end

  describe '#take_card' do
    it 'takes a card from the top of the deck' do
      top_card = deck.cards[-1]
      expect(deck.take_card).to eq top_card
    end

    it 'removes the card from the deck' do
      deck.take_card
      deck.take_card
      expect(deck.cards.size).to eq 50
    end
  end
end
