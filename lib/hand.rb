require 'card'
class Hand < Array
  def display_hand
    map(&:display_card).join(" ")
  end

  def best_value
    value = inject(0) { |memo, card| memo + card.value }
    if value > 21
      each do |card|
        value -= card.value_difference
        return value if value <= 21
      end
    end
    value
  end
end
