extends triggerMemory

func _checkCardTrigger(c:card, likelihoodMultiplier) -> bool:
	return (randi_range(1,1000)<= 125.0*likelihoodMultiplier)
	
func _perCardTrigger(c:card) -> void:
	c._increaseTriggers(1)
