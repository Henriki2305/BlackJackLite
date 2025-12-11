extends Area2D

func _mouse_enter() -> void:
	get_parent().get_parent()._createInfoBox()
	
func _mouse_exit() -> void:
	get_parent().get_parent()._removeInfoBox()
