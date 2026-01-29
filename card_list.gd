class_name cardlist extends Node2D

var g : Game
var cards : Array[card]
var d : deck
# Called when the node enters the scene tree for the first time.

func fillCont(c : card, cont : HBoxContainer) -> void:
	c.show()
	var box = Container.new()
	d.remove_child(c)
	box.add_child(c)
	box.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	box.size_flags_horizontal = Control.SIZE_EXPAND
	box.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	cont.add_child(box)
	
func _ready() -> void:
	$Control.size = get_parent().size
	g = get_parent().get_parent()
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
		var Cont = HBoxContainer.new()
		Cont.set_name("hearts")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in hearts:
			fillCont(c,Cont)
		suits += 1
	if len(diamonds) > 0:
		var Cont = HBoxContainer.new()
		Cont.set_name("diamonds")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in diamonds:
			fillCont(c,Cont)
		suits += 1
	if len(spades) > 0:
		var Cont = HBoxContainer.new()
		Cont.set_name("spades")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in spades:
			fillCont(c,Cont)
		suits += 1
	if len(clubs) > 0:
		var Cont = HBoxContainer.new()
		Cont.set_name("clubs")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in clubs:
			fillCont(c,Cont)
		suits += 1
	if len(stars) > 0:
		var Cont = HBoxContainer.new()
		Cont.set_name("stars")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in stars:
			fillCont(c,Cont)
		suits += 1
	if len(all) > 0:
		var Cont = HBoxContainer.new()
		Cont.set_name("all")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in all:
			fillCont(c,Cont)
		suits += 1
	if len(none) > 0:
		var Cont = HBoxContainer.new()
		Cont.set_name("none")
		$Control/SuitContainers.add_child(Cont)
		Cont.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		Cont.size_flags_vertical = Control.SIZE_EXPAND
		for c in none:
			fillCont(c,Cont)
		suits += 1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
