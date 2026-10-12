class_name betweenRound extends Node2D

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
	$DoorButton.hide()
	
func _showButtons() -> void:
	$StoreButton.show()
	$AdvanceButton.show()
	$DemonButton.show()
	$GuardianButton.show()
	$MagicianButton.show()
	$SoulSmithButton.show()
	$CollectorButton.show()
	$DoorButton.show()

func _ready() -> void:
	$SoulSmith.leave.connect(_showButtons)
	$Store.leave.connect(_showButtons)
	$DoorsOfOptions.leave.connect(_showButtons)
	EventBus.leftDemon.connect(_showButtons)
#	$LayerGate.aura.connect(_aura)
#	$LayerGate.boon.connect(_boon)
#	$LayerGate.curse.connect(_curse)
	
	
func _newBetweenRound() -> void:
	show()
	$Store.hide()
	$Store._createStore()
	$DemonOfHands._setHands()

func _Advance() -> void:
	
	var g : Game = get_parent()
	$Store._emptyStore()
	EventBus.advanceRound.emit()
	g._advance()
	hide()

func _EnterStore() -> void:
	$Store.show()
	_hideButtons()

	
func _EnterHandDemon() -> void:
	_hideButtons()
	$DemonOfHands.show()
	
func _EnterCollector() -> void:
	pass
	
func _EnterMagician() -> void:
	EventBus.magicianEntered.emit()
	$Magician.show()
	_hideButtons()
	
func _EnterSoulSmith() -> void:
	var a : Array[String] = ["test1","test2","test3"]
	$SoulSmith._setPossibleSouls(a)
	$SoulSmith.show()
	_hideButtons()

func _EnterDoors() -> void:
	$DoorsOfOptions.show()
	$DoorsOfOptions._setOptions()
	_hideButtons()

func _ChallengeGuardian() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
