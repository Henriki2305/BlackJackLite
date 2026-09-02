class_name card extends Node2D
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
	"bl": Enums.blessed,
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
	
var rarities = {
	"co": Enums.common,
	"un": Enums.uncommon,
	"ra": Enums.rare,
	"ul": Enums.ultraRare,
	"go": Enums.goldenRare,
	"gh": Enums.ghostRare,
	"ne": Enums.negative,
	"sh": Enums.shadowRare,
	"so": Enums.soulRare,
	"re": Enums.recursiveRare,
	"mi": Enums.midNightRare
}
	
var bustValues = {
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
	Enums.Jack: 10,
	Enums.Queen: 10,
	Enums.King: 10,
	Enums.Ace: 1
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
	Enums.eleven: 11,
	Enums.Jack: 10,
	Enums.Queen: 10,
	Enums.King: 10,
	Enums.Ace: 11
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
	pack,
	sidehand,
	llist
}

var suitNames = {
	Enums.hearts : "hearts",
	Enums.spades : "spades",
	Enums.diamonds : "diamonds",
	Enums.clubs : "clubs"
}

var triggers = 1
var rank = Enums.zero
var suit = Enums.none
var enchantment = Enums.normal
var rarity = Enums.common
var originalCard : card
var selected : bool = false
var listed : bool = false
var xind
var yind
var w  = 648
var h = 904

func _setListed(b : bool) -> void:
	listed = b
	
func _getListed() -> bool:
	return listed

func _getSelected() -> bool:
	return selected

func _setSelected(b : bool) -> void:
	selected = b

func _setTriggers(nu : int) -> void:
	triggers = nu
	
func _setOriginal(c : card) -> void:
	originalCard = c
	
func _getOriginal() -> card:
	return originalCard
	
func _getTriggers() -> int:
	return triggers
	
func _increaseTriggers(nu : int ) -> void:
	triggers += nu

func _setUsed() -> void:
	$"card base".material.set_shader_parameter("used",true)

func _ready() -> void:
	pass

func _getName() -> String:
	return str(rank, " of ", suitNames[suit])

func _burnCardFromDeck() -> void:
	show()
	var tw = get_tree().create_tween()
	tw.tween_property(self,"global_position",Vector2(randi_range(500,1420),randi_range(400,700)),0.75)
	await get_tree().create_timer(1.0).timeout
	queue_free()
	
func _getString() -> String:
	var s : String = ""
	s = s + enchantments.find_key(enchantment) + suits.find_key(suit) + rarities.find_key(rarity) + ranks.find_key(rank)	
	return s
	
func setValues(cValues : String, b : bool) -> void:
	$TakeButton.visible = false
	$BurnButton.visible = false
	var texture: TextureRect = $TextureRect
	enchantment = enchantments[cValues.left(2)]
	suit = suits[cValues[2]]
	rarity = rarities[str(cValues[3],cValues[4])]
	rank = ranks[cValues.right(-5)]
	xind = locationsx[rank]
	yind = locationsy[suit]
	texture.texture.set_region(Rect2(Vector2(xind*(w-20),yind*h),Vector2(w,h)))
	visible = false
	match enchantment:
		Enums.cursed:
			$"card base".material.set_shader_parameter("cursed", true)
		Enums.normal:
			pass
	match rarity:
		Enums.rare:
			$TextureRect.material.set_shader_parameter("rare",true)
			$"card base".material.set_shader_parameter("rare",true)
		Enums.shadowRare:
			$"card base".material.set_shader_parameter("shadow", true)
		Enums.goldenRare:
			$"card base".material.set_shader_parameter("gold", true)
		Enums.common:
			pass
			
func changeRank(r : String) -> void:
	rank = ranks[r]
	xind = locationsx[rank]
	updateAppearance()
	
func _getRank():
	return rank
	
func changeSuit(s : String) -> void:
	suit = suits[s]
	yind = locationsy[suit]
	updateAppearance()
	
func updateAppearance() -> void:
	$TextureRect.texture.set_region(Rect2(Vector2(xind*(w-20),yind*h),Vector2(w,h)))
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _getBustvalue() -> int:
	return bustValues[rank]
	
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

func _hasRarityEffect() -> bool:
	return rarity == Enums.uncommon || rarity == Enums.rare || rarity == Enums.soulRare || Enums.ultraRare

#func _rarityEffect() -> void:
#	match rarity:
#		Enums.uncommon :
#			g._increaseHandPower(_worth())
#			if rank == Enums.Ace:
#				g._increaseHandPower(10)
#		Enums.rare :
#			if randi_range(1,100) < 21*g.LikeliHoodModifier:
#				g._multiplyMultiplier(2.5)
#		Enums.ultraRare:
#			g._multiplyHandPower(1.25)
#			g._multiplySoulPower(1.25)
#			g._multiplyMultiplier(1.25)
#		Enums.soulRare :
#			g._addToSouls(2)
#		Enums.recursiveRare :
#			g._multiplyMultiplierbyPercent(1.01)

#func _enchantmentEffect() -> void:
#	match enchantment:
#		Enums.enchanted : g._increaseHandPower(5)
#		Enums.magical : g._increaseHandPower(20)
#		Enums.mythical : g._multiplyHandPower(2)
#		Enums.blessed : g._increasemultiplier(0.35)
#		Enums.holy : g._increaseSoulPower(1)
#		Enums.divine : g._multiplySoulPower(2.5)
#		Enums.cursed :
#			g._addToSouls(-1)
#			g._increaseSoulPower(10)
#		Enums.unholy :
#			g._addToSouls(-2)
#			g._multiplySoulPower(2)
#		Enums.devilish:
#			g._addToSouls(-5)
#			g._increaseSoulPower(25)
#			g._multiplySoulPower(5)
			
			
func _mouse_enter() -> void:
	if get_parent() is boosterPack:
		var sTween = get_tree().create_tween()
		sTween.tween_property(self,"scale",Vector2(1.2,1.2),0.2)
	
func _mouse_exit() -> void:
	if get_parent() is boosterPack:
		var sTween = get_tree().create_tween()
		sTween.tween_property(self,"scale",Vector2(1,1),0.1)

func _mouse_click():
	if listed:
		if selected:
			var tw = get_tree().create_tween()
			tw.tween_property(self,"position:y",position.y+50,0.15)
			selected = false
		else:
			var tw = get_tree().create_tween()
			tw.tween_property(self,"position:y",position.y-50,0.15)
			selected = true

func _unpacked() -> void:
	$TakeButton.visible = true
	$BurnButton.visible = true

func _burnCard() -> void:
	var b : boosterPack = get_parent()
	b._createCard()
	queue_free()

func _takeCard() -> void:
	$TakeButton.visible = false
	$BurnButton.visible = false
	var tween = get_tree().create_tween()
	var rotTween = get_tree().create_tween()
	rotTween.tween_property(self,"rotation_degrees", -1080,0.35)
	tween.tween_property(self,"scale", Vector2(0,0),0.35)
	await get_tree().create_timer(0.71).timeout
	visible = false
	var b : boosterPack = get_parent()
	var sto: store = b.get_parent()
	var d: deck =  sto.g._getPlayerDeck()
	b._createCard()
	b.remove_child(self)
	d._addToDeck(self)
