class_name betweenRound extends Node2D

var demonScene = preload("res://Scenes/demon_of_hands.tscn")
var smithScene = preload("res://Scenes/soul_smith.tscn")
var selectedCards : Array[card]
var currentStore

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
	currentStore = $Store
	var smithInstance = smithScene.instantiate()
	smithInstance.name = "smithInstance"
	add_child(smithInstance)
	smithInstance.global_position = Vector2(0,0)
	smithInstance.hide()
	smithInstance.leave.connect(_showButtons)
	currentStore.leave.connect(_showButtons)
#	$LayerGate.aura.connect(_aura)
#	$LayerGate.boon.connect(_boon)
#	$LayerGate.curse.connect(_curse)
	
	
func _newBetweenRound() -> void:
	show()
	currentStore.hide()
	currentStore._createStore()

func _Advance() -> void:
	
	var g : Game = get_parent()
	currentStore._emptyStore()
	g._advance()
	hide()

func _EnterStore() -> void:
	currentStore.show()
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
