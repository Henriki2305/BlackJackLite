extends Node2D
var hhScene = preload("res://Scenes/hand_holder.tscn")
var OfferedHands : Array

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	$ExitButton.pressed.connect(_leaveDemon)
func _leaveDemon() -> void:
	visible = false




func _setHands(h : Array) -> void:
	var g : Game = get_parent().get_parent()
	var x = 0
	for i in h:
		var hain : handHolder = hhScene.instantiate()
		add_child(hain)
		hain._setVals(i,g.handReqTexts[i],g.handRewardTexts[i])
		OfferedHands.append(hain)
		var pos : Vector2 = Vector2(500+300*(x%2),400+400*((x)/2))
		hain.global_position = pos
		var tween = get_tree().create_tween().set_loops(INF).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
		var tween2 = get_tree().create_tween().set_loops(INF).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
		tween.tween_property(hain,"global_position:y",pos[1]+100,5)
		tween.tween_property(hain,"global_position:y",pos[1]-100,5)
		tween2.tween_property(hain,"global_position:x",pos[0]+50,20)
		tween2.tween_property(hain,"global_position:x",pos[0]-50,20)
		x+=1
	var tween = get_tree().create_tween().set_loops(INF).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	var tween2 = get_tree().create_tween().set_loops(INF).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	var tween3 = get_tree().create_tween().set_loops(INF).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	var tween4 = get_tree().create_tween().set_loops(INF).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	$ReqButton.global_position = Vector2(500,800)
	$RewButton.global_position = Vector2(800,800)
	tween.tween_property($ReqButton,"global_position:y",900,5)
	tween.tween_property($ReqButton,"global_position:y",700,5)
	tween2.tween_property($ReqButton,"global_position:x",550,20)
	tween2.tween_property($ReqButton,"global_position:x",450,20)
	tween3.tween_property($RewButton,"global_position:y",900,5)
	tween3.tween_property($RewButton,"global_position:y",700,5)
	tween4.tween_property($RewButton,"global_position:x",850,20)
	tween4.tween_property($RewButton,"global_position:x",750,20)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
