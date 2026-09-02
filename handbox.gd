class_name handbox extends Node2D
var handScene = preload("res://Hands/BigNumberHand/BigNumberHand.tscn")
var hands : Array = []
var movedHand
var playPhase : bool = true

func _swapHandPos(i: int, j: int) -> void:
	var tempHand = hands[i]
	hands[i]._setPosition(j)
	hands[j]._setPosition(i)
	hands[i] = hands[j]
	hands[j] = tempHand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var h1 : hand = handScene.instantiate()
	add_child(h1)
	h1._handInfo("BlackJack")
	h1.position = Vector2(0,-309.5)
	var h2 : hand = handScene.instantiate()
	add_child(h2)
	h2._handInfo("pair")
	h2._setPosition(1)
	h2.position = Vector2(0,-157.5)
	hands.append(h1)
	hands.append(h2)
	h1._setBox(self)
	h2._setBox(self)
	h1.info.connect(_setInfo)
	h2.info.connect(_setInfo)

func sort_hands(a:hand, b:hand) -> bool:
	return a._getPosition() < b._getPosition()

func _getHands() -> Array[hand]:
	hands.sort_custom(sort_hands)
	return hands


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if movedHand:
		var mPos = get_global_mouse_position()
		movedHand.global_position = mPos
		for i in len(hands):
			if hands[i] != movedHand:
				var h : hand = hands[i]
				if (h._getPosition() > movedHand._getPosition() && h.global_position[1] < movedHand.global_position[1] )|| (h._getPosition() < movedHand._getPosition() && h.global_position[1] > movedHand.global_position[1]):
					_swapHandPos(i,movedHand._getPosition())
					var tween = get_tree().create_tween()
					tween.tween_property(h,"position", Vector2(0,-309.5+(h._getPosition()*152)),0.1)

func _input(event):
	if playPhase:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var h = raycast_check_mem()
				if h is hand:
					movedHand = h
			else:
				if movedHand:
					var tween = get_tree().create_tween()
					tween.tween_property(movedHand,"position", Vector2(0,-309.5+(movedHand._getPosition()*152)),0.1)
					var h = movedHand
					movedHand = null

func _getMovedHand() -> hand:
	return movedHand

func _setInfo(req:String,rew:String) -> void:
	$ReqText.text = req
	$RewText.text = rew
	print(rew)
	print(req)

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
