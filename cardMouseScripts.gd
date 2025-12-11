extends Area2D

func on_mouse_entered() -> void:
	get_parent().get_parent()._mouse_enter()
	
func on_mouse_exited() -> void:
	get_parent().get_parent()._mouse_exit()

func _input(event):
	if event.is_action_pressed("click"):
		if is_pixel_opaque(get_local_mouse_position()):
			get_parent().get_parent()._mouse_click()
