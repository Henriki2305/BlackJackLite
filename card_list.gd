class_name cardlist extends Control

var g : Game
var cards : Array[card]
# Called when the node enters the scene tree for the first time.

func _sortSuit(s: Array[CardGraphics]) -> Array[CardGraphics]:
	var result = s.duplicate()
	result.sort_custom( func(x,y):
		return x.cardReference._getRank() < y.cardReference._getRank()
	)
	return result
		
func _cancel() -> void:
	g = get_parent().get_parent()
	g._destroyList()
	
func _confirmSelection() -> void:
	var selec = cards.filter(func(c): return c._getSelected())
	var ref : Array[card] = []
	if len(selec) == 5:
		for c in selec:
			ref.append(c._getOriginal())
	var rou : betweenRound = get_parent()
	rou._setSelectedCards(ref)
		
func _ready() -> void:
	EventBus.cardListShown.connect(_createDeck)
	
func _createDeck(d : Array[CardGraphics]) -> void:
	var hearts : Array[CardGraphics] = []
	var diamonds : Array[CardGraphics] = []
	var spades : Array[CardGraphics] = []
	var clubs : Array[CardGraphics] = []
	var stars : Array[CardGraphics] = []
	var all : Array[CardGraphics] = []
	var none : Array[CardGraphics] = []
	for c in d:
		match c.cardReference.suit:
			Enums.Suit.HEARTS:
				hearts.append(c)
			Enums.Suit.DIAMONDS:
				diamonds.append(c)
			Enums.Suit.SPADES:
				spades.append(c)
			Enums.Suit.CLUBS:
				clubs.append(c)
			Enums.Suit.STARS:
				stars.append(c)
			Enums.Suit.ALL:
				all.append(c)
			Enums.Suit.NONE:
				none.append(c)
	hearts = _sortSuit(hearts)
	diamonds = _sortSuit(diamonds)
	spades = _sortSuit(spades)
	clubs = _sortSuit(clubs)
	stars = _sortSuit(stars)
	all = _sortSuit(all)
	none = _sortSuit(none)
	for c in hearts:
		$TextureRect/SuitContainers/Hearts.add_child(c.duplicate())
	for c in diamonds:
		$TextureRect/SuitContainers/Diamonds.add_child(c.duplicate())
	for c in spades:
		$TextureRect/SuitContainers/Spades.add_child(c.duplicate())
	for c in clubs:
		$TextureRect/SuitContainers/Clubs.add_child(c.duplicate())
	for c in stars:
		$TextureRect/SuitContainers/Stars.add_child(c.duplicate())
	for c in all:
		$TextureRect/SuitContainers/All.add_child(c.duplicate())
	for c in none:
		$TextureRect/SuitContainers/None.add_child(c.duplicate())
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
