class_name betweenRound extends Node2D

var storeScene = preload("res://Scenes/Store.tscn")
var demonScene = preload("res://Scenes/demon_of_hands.tscn")
var smithScene = preload("res://Scenes/soul_smith.tscn")
var selectedCards : Array[card]

# Called when the node enters the scene tree for the first time.

func _getSelectedCards() -> Array[card]:
	return selectedCards
	
func _setSelectedCards(a : Array[card]) -> void:
	selectedCards = a
	
func _hideButtons() -> void:
	$StoreButton.hide()
	$AdvanceButton.hide()
	$DemonButton.hide()
	$GuardianButton.hide()
	$MagicianButton.hide()
	$SoulSmithButton.hide()
	$CollectorButton.hide()
	
func _showButtons() -> void:
	$StoreButton.show()
	$AdvanceButton.show()
	$DemonButton.show()
	$GuardianButton.show()
	$MagicianButton.show()
	$SoulSmithButton.show()
	$CollectorButton.show()

func _ready() -> void:
	var storeIns = storeScene.instantiate()
	add_child(storeIns)
	storeIns.name = "storeInstance"
	storeIns._createStore()
	storeIns.visible = false
	var smithInstance = smithScene.instantiate()
	smithInstance.name = "smithInstance"
	add_child(smithInstance)
	smithInstance.global_position = Vector2(0,0)
	smithInstance.hide()
	smithInstance.leave.connect(_showButtons)
	storeIns.leave.connect(_showButtons)
#	$LayerGate.aura.connect(_aura)
#	$LayerGate.boon.connect(_boon)
#	$LayerGate.curse.connect(_curse)
	

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
	_hideButtons()

	
func _EnterHandDemon() -> void:
	print("e")
	var dem = demonScene.instantiate()
	add_child(dem)
	dem.global_position = Vector2(0,0)
	dem._setHands(["testhand1","testhand2"])
	_hideButtons()
	
func _EnterCollector() -> void:
	pass
	
func _EnterMagician() -> void:
	pass
	
func _EnterSoulSmith() -> void:
	var a : Array[String] = ["test1","test2","test3"]
	$smithInstance._setPossibleSouls(a)
	$smithInstance.show()
	_hideButtons()

func _ChallengeGuardian() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
