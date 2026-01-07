class_name hand extends Node2D

var triggered : bool = false
var handName : String = ""
var reqLevel : int = 1
var rewLevel : int = 1
var HandPos : int = 0
var colorness : float = 0.0
var box : hand_box
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
	$Req.visible = false
	$Rew.visible = false
	
func _setBox(b:hand_box) -> void:
	box = b
	
func _handInfo(t : String) -> void:
	handName = t
	$NameText.text = str(handName)

func _setTrigger(b: bool) -> void:
	triggered = b

func _updateHand(cards: Array) -> void:
	triggered = _checkReq(cards)

func _getPosition() -> int:
	return HandPos
	
func _setPosition(p : int) -> void:
	HandPos = p

func _checkReq(cards: Array) -> bool:
	match handName:
		"BlackJack":
			if len(cards) == 2:
				return (cards[0]._isAce() && cards[1]._worth() == 10) || (cards[1]._isAce() && cards[0]._worth() == 10)
			return false
		"pair" :
			if len(cards) == 2:
				return cards[0].rank == cards[1].rank
			return false
		"LuckySevens":
			if len(cards) < 2:
				return false
			for c in cards:
				if c._worth()!=7:
					return false
			return true
		"lovelyFaces":
			for c in cards:
				if c.suit!=Enums.hearts || !c._isFaceCard():
					return false
			return true
		"neutrality":
			return get_parent().get_parent().playerDeck._cardValuesSum() == 0
		"27":
			if len(cards) == 2:
				return (cards[0].rank == Enums.two && cards[1].rank == Enums.seven) || (cards[1].rank == Enums.two && cards[0].rank == Enums.seven)
			return false
		"none":
			return true
	return false

func _effect() -> void:
	pass

	
func _createInfoBox() -> void:
	print("test")
	if box :
		if !box.getMovedHand():
			$Req/ReqText.text = reqTexts[handName][reqLevel-1]
			$Rew/RewText.text = rewTexts[handName][rewLevel-1]
			$Req.visible = true
			$Rew.visible = true
	else:
			$Req/ReqText.text = reqTexts[handName][reqLevel-1]
			$Rew/RewText.text = rewTexts[handName][rewLevel-1]
			$Req.visible = true
			$Rew.visible = true
		
	
func _removeInfoBox() -> void:
	$Req.visible = false
	$Rew.visible = false	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if triggered:
		colorness = min(1.0,colorness+2.0*delta)
	else:
		colorness = max(0.0,colorness-3.0*delta)
	$"HandBase".material.set_shader_parameter("colorness", colorness)
