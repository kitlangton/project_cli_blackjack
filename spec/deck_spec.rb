require 'deck'

describe 'deck' do
	let(:deck) { Deck.new }

	context 'a new deck' do

		it 'has 52 cards' do
			expect(deck.cards.size).to eq 52
		end
		it 'has 13 clubs' do
			clubs = deck.cards.select { |card| card.suit == :clubs }
			expect(clubs.size).to eq 13
		end

	end

end