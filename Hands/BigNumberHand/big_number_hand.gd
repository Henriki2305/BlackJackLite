extends hand

var reqs = ["Sum of card values is at least 19","Sum of card values is at least 17","Sum of card values is at least 14"]
var rews = ["+4 soul power", "+12 soul power", "+40 soul power"]

func _setInfo() -> void:
	var req = _getReqText()
	var rew = _getRewText()
	info.emit(req,rew)
	
func _getStrings() -> Array[Array]:
	return [reqs,rews]
	
func _getReqText() -> String:
	return reqs[stats.reqLevel + 1]
	
func _getRewText() -> String:
	return rews[stats.rewLevel + 1]
	
func _checkReq(cards: Array[card]) -> bool:
	var tot = 0
	var aces = 0
	for c in cards:
		if c._isAce():
			aces +=1
		tot += c._getBustvalue()
		
	for i in range(aces):
		if tot <= 21 - 10:
			tot += 10
		
	match stats.reqLevel:
		1: return tot >= 19
		2: return tot >= 17
		3: return tot >= 14
	return false
