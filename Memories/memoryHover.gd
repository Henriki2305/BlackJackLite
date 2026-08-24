extends Area2D

var beingMoved : bool = false
signal hovered
signal unhovered

func _ready() -> void:
	get_parent().get_parent()._setHover(self)

func _setMoved(m : bool) -> void:
	beingMoved = m

func _mouse_enter() -> void:
	if(!beingMoved):
		hovered.emit()
	
func _mouse_exit() -> void:
	unhovered.emit()
