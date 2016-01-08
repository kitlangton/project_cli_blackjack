require 'player'
require 'spec_helper'

describe Player do

  let(:player) { Player.new }

  describe '#get_move' do
    it 'asks player for their move' do
      allow(player).to receive(:gets).and_return('Stand')
      expect{ player.get_move }.to output(/Hit or Stand/).to_stdout
    end

    it 'returns the move' do
      allow(player).to receive(:gets).and_return('Stand')
      expect(player.get_move).to eq :stand
    end

    it 'loops until the move is valid' do
      allow(player).to receive(:gets) do
        @counter ||= 0
        @counter += 1
      end.and_return('otheu', '4', 'Stand')
      expect(player.get_move).to eq :stand
      expect(@counter).to eq 3
    end
  end

  describe '#add_card' do
    it 'adds a card to the players hand' do
      card = instance_double("Card")
      hand = instance_double("Hand")
      player.hand = hand
      expect(hand).to receive(:<<).with(card)
      player.add_card(card)
    end
  end

  describe '#done?' do
    it 'returns true if the player has busted' do
      player.status = :bust
      expect(player.done?).to eq true
    end

    it 'returns true if the player has stood' do
      player.status = :stand
      expect(player.done?).to eq true
    end
  end

  describe '#display_hand' do
    it 'displays the players hand' do
      hand = instance_double("Hand")
      player.hand = hand
      expect(player.hand).to receive(:display_cards)
      player.display_hand
    end
  end
end
