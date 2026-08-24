class_name cardlist extends Node2D

var g : Game
var cards : Array[card]
var d : deck
# Called when the node enters the scene tree for the first time.

func fillCont(c : card, cont : TextureRect) -> void:
	c.show()
	d.remove_child(c)
	cont.add_child(c)
		
func _sortSuit(s: Array[card]) -> Array[card]:
	var ranks = [Enums.zero,Enums.one,Enums.two,Enums.three,Enums.four,Enums.five,Enums.six,Enums.seven,Enums.eight,Enums.nine,Enums.ten,Enums.eleven,Enums.Jack,Enums.Queen,Enums.King,Enums.Ace]
	var temp : Array[card] = []
	for r in ranks:
		for c in s:
			if c.rank == r:
				temp.append(c)
	return temp
		
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
	$Control.size = get_parent().size
	g = get_parent().get_parent().get_parent()
	d = g._getPlayerDeck()
	cards = d._getDeckCopy()
	var hearts : Array[card] = []
	var diamonds : Array[card] = []
	var spades : Array[card] = []
	var clubs : Array[card] = []
	var stars : Array[card] = []
	var all : Array[card] = []
	var none : Array[card] = []
	for c in cards:
		c.position = Vector2(0,0)
		match c.suit:
			Enums.hearts:
				hearts.append(c)
			Enums.diamonds:
				diamonds.append(c)
			Enums.spades:
				spades.append(c)
			Enums.clubs:
				clubs.append(c)
			Enums.stars:
				stars.append(c)
			Enums.all:
				all.append(c)
			Enums.none:
				none.append(c)
	var suits : int = 0
	if len(hearts) > 0:
		hearts = _sortSuit(hearts)
		var Cont = TextureRect.new()
		Cont.set_name("hearts")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in hearts:
			fillCont(c,Cont)
		suits += 1
		var wid = $Control.size.x * min(1.0,0.15 + 0.1*len(hearts))
		var dis = wid/len(hearts)
		var i = 0
		for c in hearts:
			c.position = Vector2(dis*i,0)
			i+=1
	if len(diamonds) > 0:
		diamonds = _sortSuit(diamonds)
		var Cont = TextureRect.new()
		Cont.set_name("diamonds")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in diamonds:
			fillCont(c,Cont)
		suits += 1
		var wid = $Control.size.x * min(1.0,0.15 + 0.1*len(diamonds))
		var dis = wid/len(diamonds)
		var i = 0
		for c in diamonds:
			c.position = Vector2(dis*i,0)
			i+=1
	if len(spades) > 0:
		spades = _sortSuit(spades)
		var Cont = TextureRect.new()
		Cont.set_name("spades")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in spades:
			fillCont(c,Cont)
		suits += 1
		var wid = $Control.size.x * min(1.0,0.15 + 0.1*len(spades))
		var dis = wid/len(spades)
		var i = 0
		for c in spades:
			c.position = Vector2(dis*i,0)
			i+=1
	if len(clubs) > 0:
		clubs = _sortSuit(clubs)
		var Cont = TextureRect.new()
		Cont.set_name("clubs")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in clubs:
			fillCont(c,Cont)
		suits += 1
		var wid = $Control.size.x * min(1.0,0.15 + 0.1*len(clubs))
		var dis = wid/len(clubs)
		var i = 0
		for c in clubs:
			c.position = Vector2(dis*i,0)
			i+=1
	if len(stars) > 0:
		stars = _sortSuit(stars)
		var Cont = TextureRect.new()
		Cont.set_name("stars")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in stars:
			fillCont(c,Cont)
		suits += 1
		var wid = $Control.size.x * min(1.0,0.15 + 0.1*len(stars))
		var dis = wid/len(stars)
		var i = 0
		for c in stars:
			c.position = Vector2(dis*i,0)
			i+=1
	if len(all) > 0:
		all = _sortSuit(all)
		var Cont = TextureRect.new()
		Cont.set_name("all")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in all:
			fillCont(c,Cont)
		suits += 1
		var wid = $Control.size.x * min(1.0,0.15 + 0.1*len(all))
		var dis = wid/len(all)
		var i = 0
		for c in all:
			c.position = Vector2(dis*i,0)
			i+=1
	if len(none) > 0:
		none = _sortSuit(none)
		var Cont = TextureRect.new()
		Cont.set_name("none")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in none:
			fillCont(c,Cont)
		suits += 1
		var wid = $Control.size.x * min(1.0,0.15 + 0.1*len(none))
		var dis = wid/len(none)
		var i = 0
		for c in none:
			c.position = Vector2(dis*i,0)
			i+=1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
