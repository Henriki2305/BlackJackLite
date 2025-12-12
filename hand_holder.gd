class_name handHolder extends Node2D

var handName : String
var requirement : String
var bonus : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _setVals(a : String, b : String, c : String) -> void:
	handName = a
	requirement = b
	bonus = c


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
