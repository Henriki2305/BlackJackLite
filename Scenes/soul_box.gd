extends Node2D

var currentSoul: soul


func _ready() -> void:
	EventBus.soulBought.connect(_addSoul)
	EventBus.soulSacrificed.connect(_removeSoul)


func _addSoul(s : soul) -> void:
	if currentSoul != null:
		currentSoul = s
		s.reparent(self)
		Global.soulRule = s.soulName

func _removeSoul() -> void:
	currentSoul.queue_free()
	currentSoul = null
	Global.soulRule = ""
