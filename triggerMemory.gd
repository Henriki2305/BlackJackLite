@abstract
extends memory
class_name triggerMemory

@abstract
func _checkCardTrigger(c:card, likelihoodMultiplier) -> bool

@abstract
func _perCardTrigger() -> void
