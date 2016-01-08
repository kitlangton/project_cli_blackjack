require 'hand'
require 'spec_helper'

describe Hand do

  let(:hand) { Hand.new }

  context 'a new hand' do
    specify 'is empty' do
      expect(hand.size).to eq 0
    end
  end

  describe '#<<' do
    it 'adds a card to the hand' do
      card = double("Card")
      hand << card
      hand << card
      expect(hand.size).to eq 2
    end
  end

  describe '#display_hand' do
    it 'displays all of its cards' do
      card = instance_double("Card")
      hand << card
      hand << card

      expect(card).to receive(:display_card).twice

      hand.display_hand
    end
  end

  describe '#best_value' do
    it 'returns the hands value' do
      card = instance_double("Card", value: 4)
      hand << card
      hand << card
      hand << card
      expect(hand.best_value).to eq 12
    end

    it 'returns the highest value under 21' do
      card = instance_double("Card", value: 11, value_difference: 10)
      hand << card
      hand << card
      hand << card
      expect(hand.best_value).to eq 13
    end
  end
end
