extends Node2D

signal boon
signal aura
signal curse

func _chooseBoon() -> void:
	emit_signal("boon")
	
func _chooseAura() -> void:
	emit_signal("aura")
	
func _chooseCurse() -> void:
	emit_signal("curse")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
