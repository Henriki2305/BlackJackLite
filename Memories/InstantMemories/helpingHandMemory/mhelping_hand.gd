extends instantMemory


# Called when the node enters the scene tree for the first time.

func _triggerEffect() -> void:
	ScoreSystem.hand.emit(10)
