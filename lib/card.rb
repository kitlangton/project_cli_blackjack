class Card
  RANK_VALUES = {
    ace: 11,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
    ten: 10,
    jack: 10,
    queen: 10,
    king: 10
  }

  attr_reader :suit, :rank

  def initialize(rank, suit)
    @suit = suit
    @rank = rank
  end

  def value
    RANK_VALUES[rank]
  end

  def low_value
    rank == :ace ? 1 : value
  end

  def value_difference
    value - low_value
  end
end
