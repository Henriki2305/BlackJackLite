extends Node2D
class_name deck
var cardScene = preload("res://Scenes/card.tscn")
var cardsdrawn = 0
var i = 0
var cardsInDeck: Array[card]
var drawableCards: Array[card]
var cardsInHand: Array[card]
var cardsInSideHand: Array[card]
var opponent : bool
var bust = false
var g : Game

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

func _doesBust(j : int) -> bool:
	if opponent:
		return j > g.dealerBust
	else:
		return j > g.playerBust


func _setSide(s : bool) -> void:
	opponent = s

func _createDeck(cardstring) -> void:
	cardsInDeck = []
	var cards = cardstring.split(".")
	for curCard in cards:
		var card_instance = cardScene.instantiate()
		card_instance.setValues(curCard, true)
		card_instance.set_name(str("card",i))
		i = i + 1
		add_child(card_instance)
		card_instance.position = Vector2(0,0)
		cardsInDeck.append(card_instance)
	drawableCards = cardsInDeck.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	g = get_parent()
	var DeckString = g._determineDeck(self)
	_createDeck(DeckString)

func _drawCard() -> void:
	if(drawableCards.is_empty()):
		print("no cards left")
		return
	drawableCards = drawableCards.filter(func(c):return c._inDeck())
	var newCard = drawableCards.pick_random()
	newCard._drawCard()
	print(newCard._getName())
	var new_position = Vector2(800+150*len(cardsInHand),850)
	var tween = get_tree().create_tween()
	if opponent:
		new_position = Vector2(800+150*len(cardsInHand),500)
	tween.tween_property(newCard,"global_position", new_position,0.25)
	cardsInHand.append(newCard)
	drawableCards = drawableCards.filter(func(c):return c._inDeck())
	drawableCards = drawableCards.filter(func(c):return c._inDeck())
	if(drawableCards.is_empty()):
		$Sprite2D.visible = false
		
func _getDeckCopy() -> Array[card]:
	var d: Array[card] = []
	for c in cardsInDeck:
		var cc = c.duplicate()
		add_child(cc)
		d.append(cc)
	return d
		
func _discardCard() -> void:
	if !cardsInHand.is_empty():
		var c = cardsInHand[-1]
		c._discardCard()
		cardsInHand.remove_at(-1)
		var cT = c.transform.get_scale()
		var tween = get_tree().create_tween()
		var scaleTween = get_tree().create_tween()
		scaleTween.tween_property(c,"scale",cT*1.1,0.1)
		tween.tween_property(c,"position", Vector2(-800+(150*(len(cardsInHand))),-400),0.5)
		tween.tween_property(c,"position", Vector2(4000,300),0.3)
		await get_tree().create_timer(0.8).timeout
		c.scale = cT
		c.visible = false
		c.position = Vector2(0,0)
		
func _restoreDeck() -> void:
	for c in cardsInDeck:
		c._returnToDeck()
		c.position = Vector2(0,0)
		c.scale = Vector2(1,1)
		c.global_position = global_position
	drawableCards = cardsInDeck.duplicate()
	$Sprite2D.visible = true

func sum(accum : int, number: int):
	return accum + number

func _cardValuesSum() -> int:
	if len(cardsInHand) == 0:
		return 0
	var card_values = cardsInHand.map(func(c): return c._worth())
	var tot = card_values.reduce(sum,0)
	if !_doesBust(tot):
		var Aces = cardsInHand.map(func(c): if c._isAce(): return 1 else: return 0).reduce(sum,0)
		while Aces > 0:
			Aces -= 1
			if !_doesBust(tot + 10):
				tot += 10
			else:
				break
	if _doesBust(tot):
		bust = true
		return 0
	bust = false
	return tot
	
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

func _addToDeck(c: card) -> void :
	cardsInDeck.append(c)
	print(cardsInDeck)
	c.position = Vector2(0,0)
	add_child(c)
	c._inDeck()

func _clearHand() -> void:
	for c in cardsInHand:
		c._discardCard()
		c.visible = false
		c.position = Vector2(0,0)
	cardsInHand.clear()
	bust = false

func _getCardsInHand() -> Array[card]:
	return cardsInHand

func _getCardsInSideHand() -> Array[card]:
	return cardsInSideHand
