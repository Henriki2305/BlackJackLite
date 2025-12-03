
class_name memory extends Node2D

var triggerType : String: #card, normal, hybrid, none
	set = _setType

func _setType(typ : String) -> void:
	triggerType = typ

func _ready() -> void:
	pass

func _getType() -> String:
	return triggerType

func _memoryTriggerCard(c : card, likelihoodmultiplier = 1) -> bool:
	return false

func _memoryTrigger(likelihoodmultiplier = 1) -> bool:
	return false	

func _memoryEffectCard(c : card, likelihoodmultiplier = 1) -> void: #String?
	pass

func _memoryEffect() -> void:
	pass
