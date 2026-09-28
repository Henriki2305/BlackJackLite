extends perCardMemory

func _memoryCreated() -> void:
	memoryStats.var1 = null

func _checkCardTrigger(c:card, likelihoodMultiplier) -> bool:
	if c._isSuit(Enums.Suit.DIAMONDS):
		if memoryStats.var1 == null:
			memoryStats.var1 = c
			print("yeap")
			return true
		else:
			return c == memoryStats.var1
	return false
	
func _perCardTrigger() -> void:
	EventBus.multiplySoulPower.emit(2)
	
func _memoryEffectRoundEnd(likelihoodmultiplier = 1) -> void:
	memoryStats.var1 = null
