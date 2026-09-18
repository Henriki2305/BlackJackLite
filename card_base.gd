extends Sprite2D

func _input(event):
	if event.is_action_pressed("click"):
		if is_pixel_opaque(get_local_mouse_position()):
			get_parent()._mouse_click()

func _updateSymbols(rank, suit) -> void:
	var c1 = ""
	var c2 = ""
	
