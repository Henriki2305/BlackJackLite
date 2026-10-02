extends perCardMemory


func _checkCardTrigger(c:card, likelihoodMultiplier) -> bool:
		return c._isSuit(Enums.Suit.HEARTS)
		
func _perCardTrigger() -> void:
	EventBus.addHandPower.emit(5)
