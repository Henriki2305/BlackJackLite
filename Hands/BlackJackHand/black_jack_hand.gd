extends hand


var reqs = ["Hand is ace and another card worth 10", "hand has both a card worth at least 10 and a card worth at least 11", "hand has at most 2 cards with their total worth above 20"]
var rews = ["+0.5 multiplier", "+2 multiplier", "x3 multiplier"]

func _getStrings() -> Array[Array]:
	return [reqs,rews]
	
func _getReqText() -> String:
	return reqs[stats.reqLevel-1]
	
func _getRewText() -> String:
	return rews[stats.rewLevel-1]
	
func _checkReq(cards: Array[card]) -> bool:
	match stats.reqLevel:
		1:
			if len(cards) == 2:
				return (cards[0]._isAce() && cards[1]._worth() == 10 )||(cards[1]._isAce() && cards[0]._worth() == 10)
		2:
			if len(cards) == 2:
				return (cards[0]._worth()>=10 && cards[0]._worth()>=11) || (cards[1]._worth()>=11 && cards[0]._worth()>=10)
		3:
			if len(cards) == 2:
				return cards[0]._worth() + cards[1]._worth() > 20
	return false

func _effect() -> void:
	match stats.rewLevel:
		1:
			EventBus.addMultiplier.emit(0.5)
		2:
			EventBus.addMultiplier.emit(2)
		3:
			EventBus.multiplyMultiplier.emit(3)
