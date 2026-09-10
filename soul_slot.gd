extends Node2D

var currentSoul : soul

func _addSoul(s: soul) -> void:
	s.reparent(self)
	currentSoul=s
	
	
func _removeSoul() -> void:
	pass
	currentSoul = null
