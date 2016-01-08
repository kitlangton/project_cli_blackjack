require 'blackjack'
require 'spec_helper'

describe Blackjack do

  let(:blackjack) { Blackjack.new }

  describe '#initialize' do
    it 'shuffles the deck' do
      deck = instance_double("Deck")
      expect(deck).to receive(:shuffle)
      Blackjack.new(deck: deck)
    end
  end

  describe '#play' do

    it 'welcomes the player to the game' do
      allow(blackjack).to receive(:gets).and_return('2')
      expect{ blackjack.play }.to output(/Welcome to Blackjack!/).to_stdout
    end

    xit 'deals the player two cards' do
      expect(blackjack).to receive(:deal).exactly(4).times
      blackjack.play
    end

    it 'asks the player for their move' do
      allow(blackjack).to receive(:gets).and_return('2')
      player_double = instance_double('Player')
      allow(player_double).to receive(:done?).and_return(false)
      allow(player_double).to receive(:add_card).and_return(false)
      blackjack.players = [ player_double, player_double ]
      blackjack.play
    end

    it 'it deals until they stand or bust'
  end

  describe '#deal' do
    it 'deals the player a card' do
      player = instance_double("Player")
      expect(player).to receive(:add_card)
      expect(blackjack.deck).to receive(:take_card)
      blackjack.deal(player)
    end
  end

  describe '#initial_deal' do
    it 'deals two cards to each player' do
      player_double = instance_double('Player')
      blackjack.players = [ player_double, player_double ]
      expect(player_double).to receive(:add_card).exactly(4).times
      blackjack.initial_deal
    end
  end

  describe '#ask_for_number_of_players' do
    it 'returns a number' do
      allow(blackjack).to receive(:gets).and_return('2')
      expect(blackjack.ask_for_number_of_players).to eq 2
    end

    it 'continues to ask until it receives a valid number' do
      allow(blackjack).to receive(:gets).and_return('a','e','2')
      expect(blackjack.ask_for_number_of_players).to eq 2
    end
  end

  describe '#game_over?' do
    it 'returns true if all players are done' do
      player_double = instance_double('Player')
      allow(player_double).to receive(:done?).and_return(true)
      blackjack.players = [ player_double, player_double ]
      expect(blackjack.game_over?).to eq true
    end

    it 'returns false if any of the players players are not done' do
      player_double = instance_double('Player')
      allow(player_double).to receive(:done?).and_return(false)
      blackjack.players = [ player_double, player_double ]
      expect(blackjack.game_over?).to eq false
    end
  end

  describe '#display_game_state' do
    it 'displays the current players hand' do
      player_double = instance_double('Player')
      # allow(player_double).to receive(:done?).and_return(false)
      blackjack.players = [ player_double, player_double ]
      expect(player_double).to receive(:display_hand)
    end
  end
end
