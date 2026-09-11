extends perCardMemory

var ca : card
# Called when the node enters the scene tree for the first time.
func _memoryCreated() -> void:
	EventBus.cardAffected.connect(_setCard)

func _setCard(c : card) -> void:
	ca = c

func _checkCardTrigger(c:card, _likelihoodMultiplier) -> bool:
	return c._worth() <= 5
		
func _perCardTrigger() -> void:
	var a = ca._worth() * 2
	EventBus.addSoulPower.emit(a)
