
class_name humility_memory extends memory

func _ready() -> void:
	super._setType("card")

func _setType(typ : String) -> void:
	triggerType = typ

func _getType() -> String:
	return triggerType

func _memoryTriggerCard(c : card, likelihoodmultiplier = 1) -> bool:
	return c.rank == Enums.zero || c.rank == Enums.one || c.rank == Enums.two || c.rank == Enums.three || c.rank == Enums.four

func _memoryTrigger(likelihoodmultiplier = 1) -> bool:
	return false	

func _memoryEffectCard(c : card, likelihoodmultiplier = 1) -> void: #String?
	get_parent()._increaseSoulPower(c._worth()*2)

func _memoryEffect() -> void:
	pass
