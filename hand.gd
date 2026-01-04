class_name hand extends Node2D

var triggered : bool = false
var handName : String = ""
var reqLevel : int = 1
var rewLevel : int = 1
var HandPos : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _handInfo(t : String) -> void:
	handName = t
	$NameText.text = str(handName)

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
