extends Node2D

var storeScene = preload("res://Store.tscn")
var demonScene = preload("res://Scenes/demon_of_hands.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var StoreButton = Button.new()
	var AdvanceButton = Button.new()
	var DemonButton = Button.new()
	StoreButton.name = "store"
	AdvanceButton.name = "advance"
	DemonButton.name = "Demon"
	StoreButton.text = "store"
	AdvanceButton.text = "advance"
	DemonButton.text = "Demon of many hands and faces"
	StoreButton.pressed.connect(_EnterStore)
	AdvanceButton.pressed.connect(_Advance)
	DemonButton.pressed.connect(_EnterHandDemon)
	add_child(StoreButton)
	add_child(AdvanceButton)
	add_child(DemonButton)
	StoreButton.position = Vector2(200,200)
	AdvanceButton.position = Vector2(0,200)
	DemonButton.position = Vector2(400,200)
	 # Replace with function body.

func _Advance() -> void:
	var g : Game = get_parent()
	$storeInstance._emptyStore()
	$storeInstance.queue_free()
	g._advance()
	g._getPlayerDeck()._restoreDeck()
	g.opponentDeck._restoreDeck()

func _EnterStore() -> void:
	var store = storeScene.instantiate()
	store.global_position = Vector2(0,0)
	add_child(store)
	store.name = "storeInstance"
	store._createStore()
	
func _EnterHandDemon() -> void:
	print("e")
	var dem = demonScene.instantiate()
	add_child(dem)
	dem.position = Vector2(300,300)
	dem._setHands(["testhand1","testhand2","testhand3"])
	
func _EnterSoulSmit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
