extends Node2D

var storeScene = preload("res://Scenes/Store.tscn")
var demonScene = preload("res://Scenes/demon_of_hands.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var StoreButton = Button.new()
	var AdvanceButton = Button.new()
	var DemonButton = Button.new()
	var GuardianButton = Button.new()
	StoreButton.name = "Store"
	AdvanceButton.name = "Advance"
	DemonButton.name = "Demon"
	GuardianButton.name = "Guardian"
	StoreButton.text = "store"
	AdvanceButton.text = "advance"
	DemonButton.text = "Demon of many hands and faces"
	GuardianButton.text = "Guardian"
	StoreButton.pressed.connect(_EnterStore)
	AdvanceButton.pressed.connect(_Advance)
	DemonButton.pressed.connect(_EnterHandDemon)
	GuardianButton.pressed.connect(_ChallengeGuardian)
	add_child(StoreButton)
	add_child(AdvanceButton)
	add_child(DemonButton)
	add_child(GuardianButton)
	StoreButton.position = Vector2(200,200)
	AdvanceButton.position = Vector2(0,200)
	DemonButton.position = Vector2(400,200)
	GuardianButton.position = Vector2(600,200)
	var storeIns = storeScene.instantiate()
	add_child(storeIns)
	storeIns.name = "storeInstance"
	storeIns._createStore()
	storeIns.visible = false

func _Advance() -> void:
	var g : Game = get_parent()
	$storeInstance._emptyStore()
	$storeInstance.queue_free()
	g._advance()
	g._getPlayerDeck()._restoreDeck()
	g.opponentDeck._restoreDeck()
	queue_free()

func _EnterStore() -> void:
	$storeInstance.visible = true
	$storeInstance.global_position = Vector2(960,540)

	
func _EnterHandDemon() -> void:
	print("e")
	var dem = demonScene.instantiate()
	add_child(dem)
	dem.global_position = Vector2(0,0)
	dem._setHands(["testhand1","testhand2","testhand3"])
	
func _EnterCollector() -> void:
	pass
	
func _EnterMagician() -> void:
	pass
	
func _EnterSoulSmith() -> void:
	pass

func _ChallengeGuardian() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
