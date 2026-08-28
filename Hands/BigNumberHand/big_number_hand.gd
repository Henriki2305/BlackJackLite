extends hand

func _setInfo() -> void:
	var req = ""
	match stats.reqLevel:
		1: req = "Sum of card values is at least 19"
		2: req = "Sum of card values is at least 17"
		3: req = "Sum of card values is at least 14"
	var rew = ""
	match stats.rewLevel:
		1: rew = "+4 soul power"
		2: rew = "+12 soul power"
		3: rew = "40"
	info.emit(req,rew)
	
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
