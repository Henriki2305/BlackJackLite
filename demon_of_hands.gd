extends Node2D
var hhScene = preload("res://Scenes/hand_holder.tscn")
var OfferedHands : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _setHands(h : Array) -> void:
	var g : Game = get_parent().get_parent()
	var x = 0
	for i in h:
		x+=1
		var hain : handHolder = hhScene.instantiate()
		add_child(hain)
		hain._setVals(i,g.handReqTexts[i],g.handRewardTexts[i])
		OfferedHands.append(hain)
		hain.global_position = Vector2(x*500+600+randi_range(-200,200),500+randi_range(-200,200))
		var tween = get_tree().create_tween()
		tween.tween_property(hain,"global_position",Vector2(x*300+600+randi_range(-200,200),500+randi_range(-200,200)),6,).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(hain,"global_position",Vector2(x*300+600+randi_range(-200,200),500+randi_range(-200,200)),6,).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(hain,"global_position",Vector2(x*300+600+randi_range(-200,200),500+randi_range(-200,200)),6,).set_trans(Tween.TRANS_BOUNCE)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
