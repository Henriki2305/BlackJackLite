extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var StoreButton = Button.new()
	var AdvanceButton = Button.new()
	StoreButton.name = "store"
	AdvanceButton.text = "advance"
	StoreButton.text = "store"
	AdvanceButton.text = "advance"
	StoreButton.pressed.connect(_EnterStore)
	AdvanceButton.pressed.connect(_Advance)
	add_child(StoreButton)
	add_child(AdvanceButton)
	StoreButton.position = Vector2(200,200)
	AdvanceButton.position = Vector2(0,200)
	pass # Replace with function body.

func _Advance() -> void:
	var g : Game = get_parent()
	g._advance()

func _EnterStore() -> void:
	pass
	
func _EnterSoulSmit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
