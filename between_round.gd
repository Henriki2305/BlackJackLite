extends Node2D

var storeScene = preload("res://Store.tscn")

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
	$storeInstance._emptyStore()
	$storeInstance.queue_free()
	g._advance()
	g._getPlayerDeck()._restoreDeck()
	g.opponentDeck._restoreDeck()

func _EnterStore() -> void:
	var store = storeScene.instantiate()
	store.position = Vector2(0,0)
	add_child(store)
	store.name = "storeInstance"
	store._createCards()
	
func _EnterSoulSmit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
