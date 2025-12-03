extends Node2D
class_name deck
const Enums = preload("res://Enums.gd")
var cardScene = preload("res://Scenes/card.tscn")
var cardsdrawn = 0
var i = 0
var cardsInDeck: Array[card]
var drawableCards: Array[card]
var cardsInHand: Array[card]
var suits = {
	"h": Enums.hearts,
	"d": Enums.diamonds,
	"s": Enums.spades,
	"c": Enums.clubs,	
	"t": Enums.stars,
	"a": Enums.all,
	"n": Enums.none
}
var enchantments = {
	"no": Enums.normal,
	"en": Enums.enchanted,
	"ma": Enums.magical,
	"my": Enums.mythical,
	"bl": Enums.mythical,
	"ho": Enums.holy,
	"di": Enums.divine,
	"cu": Enums.cursed,
	"un": Enums.unholy,
	"de": Enums.devilish
}

var ranks = {
	"0": Enums.zero,
	"1": Enums.one,
	"2": Enums.two,
	"3": Enums.three,
	"4": Enums.four,
	"5": Enums.five,
	"6": Enums.six,
	"7": Enums.seven,
	"8": Enums.eight,
	"9": Enums.nine,
	"10": Enums.ten,
	"11": Enums.eleven,
	"j": Enums.Jack,
	"q": Enums.Queen,
	"k": Enums.King,
	"a": Enums.Ace
	}



func _createDeck(cardstring) -> void:
	cardsInDeck = []
	var cards = cardstring.split(".")
	for curCard in cards:
		var card_instance = cardScene.instantiate()
		card_instance.setValues(curCard)
		card_instance.set_name(str("card",i))
		i = i + 1
		add_child(card_instance)
		card_instance.position = Vector2(0,0)
		cardsInDeck.append(card_instance)
	drawableCards = cardsInDeck.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	var DeckString = get_parent()._determineDeck(self)
	_createDeck(DeckString)
		
func _drawCard() -> void:
	if(drawableCards.is_empty()):
		print("no cards left")
		return
	drawableCards = drawableCards.filter(func(c):return c._inDeck())
	var newCard = drawableCards.pick_random()
	newCard._drawCard()
	var new_position = Vector2(-800+(150*len(cardsInHand)),-350)
	var tween = get_tree().create_tween()
	tween.tween_property(newCard,"position", new_position,0.25)
	cardsInHand.append(newCard)
	drawableCards = drawableCards.filter(func(c):return c._inDeck())
	drawableCards = drawableCards.filter(func(c):return c._inDeck())
	if(drawableCards.is_empty()):
		$Sprite2D.visible = false
		
func _discardCard() -> void:
	if !cardsInHand.is_empty():
		var c = cardsInHand[-1]
		var cT = c.transform.get_scale()
		var tween = get_tree().create_tween()
		tween.tween_property(c,"scale",cT*1.1,0.1)
		tween.tween_property(c,"position", Vector2(-800+(150*(len(cardsInHand)-1)),-400),0.5)
		tween.tween_property(c,"position", Vector2(4000,300),0.3)
		await get_tree().create_timer(0.8).timeout
		tween.tween_property(c,"scale",cT,0.5)
		await get_tree().create_timer(0.6).timeout
		c._discardCard()
		cardsInHand.remove_at(-1)

func sum(accum : int, number: int):
	return accum + number


func _cardValuesSum() -> int:
	if len(cardsInHand) == 0:
		return 0
	var card_values = cardsInHand.map(func(c): return c._worth())
	var tot = card_values.reduce(sum,0)
	if tot > Global.PlayerNumberMax:
		return tot
	else:
		var Aces = cardsInHand.map(func(c): if c._isAce(): return 1 else: return 0).reduce(sum,0)
		while Aces > 0:
			Aces -= 1
			if tot + 10 <= Global.PlayerNumberMax:
				tot += 10
			else:
				return tot
	return tot
	
func _hasHand(handName) -> bool:
	match handName:
		"normal":
			return _cardValuesSum()<=21
		"BlackJack":
			if len(cardsInHand) == 2:
				return (cardsInHand[0]._isAce() && cardsInHand[1]._worth() == 10) || (cardsInHand[1]._isAce() && cardsInHand[0]._worth() == 10)
			return false
		"pair" :
			if len(cardsInHand) == 2:
				return cardsInHand[0].rank == cardsInHand[1].rank
			return false
		"LuckySevens":
			if len(cardsInHand) < 2:
				return false
			for c in cardsInHand:
				if c._worth()!=7:
					return false
			return true
		"lovelyFaces":
			for c in cardsInHand:
				if c.suit!=Enums.hearts || !c._isFaceCard():
					return false
			return true
		"neutrality":
			return _cardValuesSum() == 0
		"27":
			if len(cardsInHand) == 2:
				return (cardsInHand[0].rank == Enums.two && cardsInHand[1].rank == Enums.seven) || (cardsInHand[1].rank == Enums.two && cardsInHand[0].rank == Enums.seven)
			return false
		"none":
			return true
	return false

func _clearHand() -> void:
	for c in cardsInHand:
		c._discard()
	cardsInHand.clear()
