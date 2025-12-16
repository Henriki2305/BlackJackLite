extends Node2D

var cardSet : Array = []
var sc = scale
var cSet : String
var opening : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _mouse_enter() -> void:
	if !opening:
		var sTween = get_tree().create_tween()
		sTween.tween_property(self,"scale",sc*1.2,0.1)
	
func _mouse_exit() -> void:
	if !opening:
		var sTween = get_tree().create_tween()
		sTween.tween_property(self,"scale",sc,0.1)


func _mouse_click():
	opening = true
	var sTween = get_tree().create_tween()
	sTween.tween_property(self,"scale",sc,0.1)
	
