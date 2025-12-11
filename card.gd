class_name card extends Node2D
const Enums = preload("res://Enums.gd")
var location
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
	
var values = {
	Enums.zero: 0,
	Enums.one: 1,
	Enums.two: 2,
	Enums.three: 3,
	Enums.four: 4,
	Enums.five: 5,
	Enums.six: 6,
	Enums.seven: 7,
	Enums.eight: 8,
	Enums.nine: 9,
	Enums.ten: 10,
	Enums.eleven: 10,
	Enums.Jack: 10,
	Enums.Queen: 10,
	Enums.King: 11,
	Enums.Ace: 1
	}
	
var locationsx = {
	Enums.zero: 0,
	Enums.one: 1,
	Enums.two: 2,
	Enums.three: 3,
	Enums.four: 4,
	Enums.five: 5,
	Enums.six: 6,
	Enums.seven: 7,
	Enums.eight: 8,
	Enums.nine: 9,
	Enums.ten: 10,
	Enums.eleven: 11,
	Enums.Jack: 12,
	Enums.Queen: 13,
	Enums.King: 14,
	Enums.Ace: 15
}

var locationsy = {
	Enums.hearts : 0,
	Enums.spades: 1,
	Enums.clubs: 2,
	Enums.diamonds: 3,
	Enums.stars: 4,
	Enums.all: 5,
	Enums.none: 6
}

enum {
	ddeck,
	hand,
	discard,
	pack
}

var suitNames = {
	Enums.hearts : "hearts",
	Enums.spades : "spades",
	Enums.diamonds : "diamonds",
	Enums.clubs : "clubs"
}

var rank = Enums.zero
var suit = Enums.none
var enchantment = Enums.normal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _getName() -> String:
	return str(rank, " of ", suitNames[suit])

func setValues(cValues : String) -> void:
	var texture: TextureRect = $TextureRect
	enchantment = enchantments[cValues.left(2)]
	suit = suits[cValues[2]]
	rank = ranks[cValues.right(-3)]
	var xind = locationsx[rank]
	var yind = locationsy[suit]
	var w  = 648
	var h = 904
	texture.texture.set_region(Rect2(Vector2(xind*(w-20),yind*h),Vector2(w,h)))
	visible = false
	location = ddeck
	match enchantment:
		Enums.cursed:
			$"card base".material.set_shader_parameter("cursed", true)
		Enums.normal:
			pass
	
func _drawCard() -> void:
	location = hand
	visible = true

func _discardCard() -> void:
	location = discard

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _returnToDeck() -> void:
	location = ddeck

func _inDeck() -> bool:
	return location == ddeck
	
func _inHand() -> bool:
	return location == hand
	
func _inStore() -> bool:
	return location == pack
	
func _worth() -> int:
	return values[rank]
	
func _maxValue() -> int:
	if rank == Enums.Ace:
		return 11
	return _worth()

func _isAce() -> bool:
	return rank == Enums.Ace

func _isFaceCard() -> bool:
	return rank == Enums.Jack || rank == Enums.Queen || rank == Enums.King


func _mouse_enter() -> void:
	if location == pack:
		var sTween = get_tree().create_tween()
		sTween.tween_property(self,"scale",Vector2(1.2,1.2),0.2)
	
func _mouse_exit() -> void:
	if location == pack:
		var sTween = get_tree().create_tween()
		sTween.tween_property(self,"scale",Vector2(1,1),0.1)

func _mouse_click():
	if location == pack:
		_takeCard()

func _unpacked() -> void:
	location = pack

func _takeCard() -> void:
	location = ddeck
	var tween = get_tree().create_tween()
	var rotTween = get_tree().create_tween()
	rotTween.tween_property(self,"rotation_degrees", -1080,0.35)
	tween.tween_property(self,"scale", Vector2(0,0),0.35)
	await get_tree().create_timer(0.71).timeout
	var sto: store = get_parent()
	var d: deck =  sto.g._getPlayerDeck()
	sto._resetPos(self)
	sto.remove_child(self)
	d._addToDeck(self)
