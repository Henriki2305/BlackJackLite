class_name betweenRound extends Node2D

var storeScene = preload("res://Scenes/Store.tscn")
var demonScene = preload("res://Scenes/demon_of_hands.tscn")
var selectedCards : Array[card]

# Called when the node enters the scene tree for the first time.

func _getSelectedCards() -> Array[card]:
	return selectedCards
	
func _setSelectedCards(a : Array[card]) -> void:
	selectedCards = a

func _ready() -> void:
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
	dem._setHands(["testhand1","testhand2"])
	
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
