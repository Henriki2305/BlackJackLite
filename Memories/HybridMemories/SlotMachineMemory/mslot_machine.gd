extends hybridMemory


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _checkCardTrigger(c:card, likelihoodMultiplier) -> bool:
		if(c._getRank() == Enums.seven):
			if(randi_range(1,1000)<= 500.0*likelihoodMultiplier):
				return true
		return false
		
func _perCardTrigger() -> void:
	memoryStats.var1 += 3

func _triggerEffect() -> void:
	EventBus.addHandPower.emit(memoryStats.var1)
