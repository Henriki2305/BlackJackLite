@abstract
extends memory
class_name perCardMemory

@abstract
func _checkCardTrigger(c:card, likelihoodMultiplier) -> bool

@abstract
func _perCardTrigger() -> void
