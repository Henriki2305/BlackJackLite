class_name Smith extends Node2D

func _NewSoul() -> void:
	pass

func _returnBack() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SmithButton.pressed.connect(_NewSoul)
	$ReturnButton.pressed.connect(_returnBack)
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
