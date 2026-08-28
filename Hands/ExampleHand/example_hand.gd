extends hand

func _checkReq(cards: Array) -> bool:
	match stats.reqLevel:
		1: return true
		2: return false
		3: return true
	return false
	
func _setInfo() -> void:
	info.emit("testReq","testRew")
	
