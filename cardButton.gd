extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _input(event):
	if visible:
		var c : card = get_parent()
		if event.is_action_pressed("click"):
			if is_pixel_opaque(get_local_mouse_position()):
				if name == "TakeButton":
					c._takeCard()
				if name == "BurnButton":
					c._burnCard()
