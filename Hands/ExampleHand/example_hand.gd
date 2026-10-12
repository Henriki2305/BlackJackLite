extends hand

func _checkReq(cards: Array) -> bool:
	var a = 0
	for c:card in cards:
		if c._getRank() == Enums.Rank.ACE:
			a +=1
	match stats.reqLevel:
		1: return a > 4
		2: return a > 3
		3: return a > 2
	return false

func _getStrings() -> Array[Array]:
	return [["testReq"],["testRew"]]

func _getReqText() -> String:
	return "testReq"
	
	
func _getRewText() -> String:
	return "testRew"

func _effect() -> void:
	EventBus.addHandPower.emit(1)
