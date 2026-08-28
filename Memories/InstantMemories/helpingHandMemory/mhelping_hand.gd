extends instantMemory


# Called when the node enters the scene tree for the first time.

func _triggerEffect() -> void:
	EventBus.addHandPower.emit(10)
