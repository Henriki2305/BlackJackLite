extends Node2D
class_name card
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
	deck,
	hand,
	discard
}

var rank = Enums.zero
var suit = Enums.none
var enchantment = Enums.normal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func setValues(cValues : String) -> void:
	var texture: TextureRect = $TextureRect
	enchantment = enchantments[cValues.left(2)]
	suit = suits[cValues[2]]
	rank = ranks[cValues.right(-3)]
	var xind = locationsx[rank]
	var yind = locationsy[suit]
	var w  = 648
	var h = 904
	texture.texture.set_region(Rect2(Vector2(xind*w,yind*h),Vector2(w,h)))
	visible = false
	location = deck
	
func _drawCard() -> void:
	location = hand
	visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _inDeck() -> bool:
	return location == deck
	
func _inHand() -> bool:
	return location == hand
	
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
