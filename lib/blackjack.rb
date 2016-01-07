Class: BlackJack
 	play 
 		instructions 
 		display initial hand of Player
 		what you like to hit, stand
 		if hit, 
 			deal a card, 
 			display new hand
 			check_for_loss
 			turn = dealer
 		else
 			check_for_loss
 		end
 		

Class: Player
	hit
	stand
	fold
	hand
SubClass: Dealer < Player
	hand
	hit
	stand

class BlackJack
end