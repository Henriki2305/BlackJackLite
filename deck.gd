extends Node2D
class_name deck
var cardScene = preload("res://Scenes/card.tscn")
var cardsdrawn = 0
var i = 0
var cardsInDeck: Array[card]
var opponent : bool
var bust = false

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
	"a": Enums.Ace,
	"pi": Enums.pi,
	"e": Enums.e,
	"12": Enums.twelwe
	}

func _setSide(s : bool) -> void:
	opponent = s

#func _createDeck(cardstring) -> void:
#	cardsInDeck = []
#	var cards = cardstring.split(".")
#	for curCard in cards:
#		var card_instance : card = cardScene.instantiate()
#		card_instance.setValues(curCard, true)
#		card_instance.set_name(str("card",i))
#		i = i + 1
#		add_child(card_instance)
#		card_instance.position = Vector2(0,0)
#		cardsInDeck.append(card_instance)
#	drawableCards = cardsInDeck.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
#	var DeckString = g._determineDeck(self)
#	_createDeck(DeckString)



func _drawCard() -> void:
	var cards = get_children().filter(func(c): c is card)
	if(!cards.is_empty()):
		var c = cards.pick_random()
		EventBus.cardDrawn.emit(c)
	if(cards.is_empty()):
		$DeckSprite.hide()
		
func _drawSideHand() -> void:
	var cards = get_children().filter(func(c): c is card)
	if(!cards.is_empty()):
		var c = cards.pick_random()
		EventBus.cardDrawnSideHand.emit(c)
	if(cards.is_empty()):
		$DeckSprite.hide()
				
		
func _getDeckCopy() -> Array[card]:
	var d: Array[card] = []
	for c in cardsInDeck:
		var s = c._getString()
		var cc = cardScene.instantiate()
		cc.setValues(s,true)
		cc._setOriginal(c)
		cc._setListed(true)
		add_child(cc)
		d.append(cc)
		if(!c._inDeck()):
			cc._setUsed()
			print("rööki")
	return d
	
func _burnCards(s : String) -> void:
	match s:
		"hearts":
			for c in cardsInDeck:
				if c.suit == Enums.hearts:
					cardsInDeck.erase(c)
					c._burnCardFromDeck()
		"clubs":
			for c in cardsInDeck:
				if c.suit == Enums.clubs:
					cardsInDeck.erase(c)
					c._burnCardFromDeck()
		"diamonds":
			for c in cardsInDeck:
				if c.suit == Enums.diamonds:
					cardsInDeck.erase(c)
					c._burnCardFromDeck()
		"spades":
			for c in cardsInDeck:
				if c.suit == Enums.spades:
					cardsInDeck.erase(c)
					c._burnCardFromDeck()
		"stars":
			for c in cardsInDeck:
				if c.suit == Enums.stars:
					cardsInDeck.erase(c)
					c._burnCardFromDeck()
		"faces":
			for c in cardsInDeck:
				if c._isFaceCard():
					cardsInDeck.erase(c)
					c._burnCardFromDeck()
		"big":
			for c in cardsInDeck:
				if c._worth() > 5 && !c._isFaceCard():
					cardsInDeck.erase(c)
					c._burnCardFromDeck()
		"small":
			for c in cardsInDeck:
				if c._worth() <= 5 || c._isAce():
					cardsInDeck.erase(c)
					c._burnCardFromDeck()

func _addToDeck(c: card) -> void :
	cardsInDeck.append(c)
	print(cardsInDeck)
	c.position = Vector2(0,0)
	add_child(c)
	c._inDeck()
