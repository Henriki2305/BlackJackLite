extends instantMemory

func _memoryCreated() -> void:
	memoryStats.var1 = 0
	EventBus.loseSouls.connect(_lostSouls)
	EventBus.roundWon.connect(_winRound)

func _triggerEffect() -> void:
	EventBus.addMultiplier.emit(memoryStats.var1)

func _lostSouls(a : int) -> void:
	memoryStats.var1+=(a*0.2)
	
func _winRound(_x) -> void:
	memoryStats.var1-=0.5
	memoryStats.var1 = max(memoryStats.var1,0)
