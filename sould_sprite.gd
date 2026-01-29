extends Sprite2D

func _input(event):
	if visible:
		if event.is_action_pressed("click"):
			if is_pixel_opaque(get_local_mouse_position()):
				get_parent()._hideButton()
		if event.is_action_pressed("rightclick"):
			if is_pixel_opaque(get_local_mouse_position()):
				get_parent()._showButton()
