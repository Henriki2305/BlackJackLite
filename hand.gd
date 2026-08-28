@abstract
class_name hand extends Node2D

@export var stats : handData
var triggered : bool = false
var handName : String = ""
var reqLevel : int = 1
var rewLevel : int = 1
var HandPos : int = 0
var colorness : float = 0.0
var box : handbox
signal info
var reqTexts: Dictionary = {
	"BlackJack" : ["2 cards, one of which is ace and another any card with value of 10"],
	"pair" : ["2 cards with the same rank"]
}
var rewTexts: Dictionary = {
	"BlackJack" : ["test","test2"],
	"pair" : [""]
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HandBase/Area2D.mouse_entered.connect(_setInfo)
	
	
func _setBox(b:handbox) -> void:
	box = b
	
func _handInfo(t : String) -> void:
	handName = t
	$HandBase/NameText.text = str(handName)

func _setTrigger(b: bool) -> void:
	triggered = b

func _updateHand(cards: Array) -> void:
	triggered = _checkReq(cards)

func _getPosition() -> int:
	return HandPos
	
func _setPosition(p : int) -> void:
	HandPos = p

@abstract
func _checkReq(cards: Array) -> bool
#	match handName:
#		"BlackJack":
#			if len(cards) == 2:
#				return (cards[0]._isAce() && cards[1]._worth() == 10) || (cards[1]._isAce() && cards[0]._worth() == 10)
#			return false
#		"pair" :
#			if len(cards) == 2:
#				return cards[0].rank == cards[1].rank
#			return false
#		"LuckySevens":
#			if len(cards) < 2:
#				return false
#			for c in cards:
#				if c._worth()!=7:
#					return false
#			return true
#		"lovelyFaces":
#			for c in cards:
#				if c.suit!=Enums.hearts || !c._isFaceCard():
#					return false
#			return true
#		"neutrality":
#			return get_parent().get_parent().playerDeck._cardValuesSum() == 0
#		"27":
#			if len(cards) == 2:
#				return (cards[0].rank == Enums.two && cards[1].rank == Enums.seven) || (cards[1].rank == Enums.two && cards[0].rank == Enums.seven)
#			return false
#		"none":
#			return true
#	return false

func _effect() -> void:
	pass

@abstract
func _setInfo() -> void
#	info.emit(reqTexts[handName][reqLevel-1],rewTexts[handName][rewLevel-1])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if triggered:
		colorness = min(1.0,colorness+2.0*delta)
	else:
		colorness = max(0.0,colorness-3.0*delta)
	$"HandBase".material.set_shader_parameter("colorness", colorness)
