extends Node2D

class_name memory

var triggerType : String: #card, normal, none
	set = _setType
	
var game: Game = get_parent()

func _setType(typ : String) -> void:
	triggerType = typ

func _ready() -> void:
	pass
	
func _getGame() -> Game:
	return game

func _memoryTriggerCard(c : card, likelihoodmultiplier = 1) -> bool:
	return false

func _memoryTrigger(likelihoodmultiplier) -> bool:
	return false	

func _memoryEffectCard(c : card, likelihoodmultiplier = 1) -> void: #String?
	pass

func _memoryEffect() -> void:
	pass
