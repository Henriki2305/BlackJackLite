class_name hand_box extends Node2D
var handScene = preload("res://Scenes/hand.tscn")
var hands : Array = []
var movedHand

func _swapHandPos(i: int, j: int) -> void:
	var tempHand = hands[i]
	hands[i]._setPosition(j)
	hands[j]._setPosition(i)
	hands[i] = hands[j]
	hands[j] = tempHand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var h1 = handScene.instantiate()
	add_child(h1)
	h1._handInfo("BlackJack")
	h1.position = Vector2(0,0)
	var h2 = handScene.instantiate()
	add_child(h2)
	h2._handInfo("Jack Black")
	h2.position = Vector2(0,200)
	h2._setPosition(1)
	hands.append(h1)
	hands.append(h2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if movedHand:
		var mPos = get_global_mouse_position()
		movedHand.global_position = mPos
		for i in len(hands):
			if hands[i] != movedHand:
				var h : hand = hands[i]
				if (h._getPosition() > movedHand._getPosition() && h.global_position[1] < movedHand.global_position[1] )|| (h._getPosition() < movedHand._getPosition() && h.global_position[1] > movedHand.global_position[1]):
					_swapHandPos(i,movedHand._getPosition())
					var tween = get_tree().create_tween()
					tween.tween_property(h,"global_position", Vector2(400,500+(h._getPosition()*120)),0.1)

func _input(event):
	if get_parent().playPhase:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var h = raycast_check_mem()
				if h is hand:
					movedHand = h
			else:
				if movedHand:
					var tween = get_tree().create_tween()
					tween.tween_property(movedHand,"global_position", Vector2(200,500+(movedHand._getPosition()*120)),0.1)
					var h = movedHand
					movedHand = null

func raycast_check_mem():
	var sState = get_world_2d().direct_space_state
	var par = PhysicsPointQueryParameters2D.new()
	par.position = get_global_mouse_position()
	par.collide_with_areas = true
	par.collision_mask = 1
	var res = sState.intersect_point(par)
	if res.size() >0:
		return res[0].collider.get_parent().get_parent()

func _addHand(h : hand) -> void:
	hands.append(h)
