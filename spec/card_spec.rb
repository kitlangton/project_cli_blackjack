require 'card'

describe 'card' do

  let(:card) { Card.new(:ace, :spades) }

	describe '#initialize' do
		it 'is initialzed with a rank and suit' do
      expect{ card }.to_not raise_error
		end
	end

  describe '#suit' do
    it "has a suit" do
      expect(card.suit).to eq :spades
    end
  end

  describe '#rank' do
    it "has a rank" do
      expect(card.rank).to eq :ace
    end
  end

  describe '#value' do
    it "has a value" do
      expect(card.value).to eq 11
    end
  end

  describe '#low_value' do
    it "has a low value" do
      expect(card.low_value).to eq 1
    end
  end

  describe '#value_difference' do
    it "it returns the difference between the low and high values" do
      expect(card.value_difference).to eq 10
    end
  end
end
