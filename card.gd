class_name card extends Node2D
var suits = {
	"h": Enums.Suit.HEARTS,
	"d": Enums.Suit.DIAMONDS,
	"s": Enums.Suit.SPADES,
	"c": Enums.Suit.CLUBS,	
	"t": Enums.Suit.STARS,
	"a": Enums.Suit.ALL,
	"n": Enums.Suit.NONE
}
var enchantments = {
	"no": Enums.Edition.NORMAL,
	"en": Enums.Edition.ENCHANTED,
	"ma": Enums.Edition.MAGICAL,
	"my": Enums.Edition.MYTHICAL,
	"bl": Enums.Edition.BLESSED,
	"ho": Enums.Edition.HOLY,
	"di": Enums.Edition.DIVINE,
	"cu": Enums.Edition.CURSED,
	"un": Enums.Edition.UNHOLY,
	"de": Enums.Edition.DEVILISH
}


var ranks = {
	"0": Enums.Rank.ZERO,
	"1": Enums.Rank.ONE,
	"2": Enums.Rank.TWO,
	"3": Enums.Rank.THREE,
	"4": Enums.Rank.FOUR,
	"5": Enums.Rank.FIVE,
	"6": Enums.Rank.SIX,
	"7": Enums.Rank.SEVEN,
	"8": Enums.Rank.EIGHT,
	"9": Enums.Rank.NINE,
	"10": Enums.Rank.TEN,
	"11": Enums.Rank.ELEVEN,
	"j": Enums.Rank.JACK,
	"q": Enums.Rank.QUEEN,
	"k": Enums.Rank.KING,
	"a": Enums.Rank.ACE
	}
	
var rarities = {
	"co": Enums.Rarity.COMMON,
	"un": Enums.Rarity.UNCOMMON,
	"ra": Enums.Rarity.RARE,
	"ul": Enums.Rarity.ULTRARARE,
	"go": Enums.Rarity.GOLDENRARE,
	"gh": Enums.Rarity.GHOSTRARE,
	"ne": Enums.Rarity.NEGATIVE,
	"sh": Enums.Rarity.SHADOWRARE,
	"so": Enums.Rarity.SOULRARE,
	"re": Enums.Rarity.RECURSIVERARE,
	"mi": Enums.Rarity.MIDNIGHTRARE
}
	
var bustValues = {
	Enums.Rank.ZERO: 0,
	Enums.Rank.ONE: 1,
	Enums.Rank.TWO: 2,
	Enums.Rank.THREE: 3,
	Enums.Rank.FOUR: 4,
	Enums.Rank.FIVE: 5,
	Enums.Rank.SIX: 6,
	Enums.Rank.SEVEN: 7,
	Enums.Rank.EIGHT: 8,
	Enums.Rank.NINE: 9,
	Enums.Rank.TEN: 10,
	Enums.Rank.ELEVEN: 11,
	Enums.Rank.JACK: 10,
	Enums.Rank.QUEEN: 10,
	Enums.Rank.KING: 10,
	Enums.Rank.ACE: 1
}
	
var values = {
	Enums.Rank.ZERO: 0,
	Enums.Rank.ONE: 1,
	Enums.Rank.TWO: 2,
	Enums.Rank.THREE: 3,
	Enums.Rank.FOUR: 4,
	Enums.Rank.FIVE: 5,
	Enums.Rank.SIX: 6,
	Enums.Rank.SEVEN: 7,
	Enums.Rank.EIGHT: 8,
	Enums.Rank.NINE: 9,
	Enums.Rank.TEN: 10,
	Enums.Rank.ELEVEN: 11,
	Enums.Rank.JACK: 10,
	Enums.Rank.QUEEN: 10,
	Enums.Rank.KING: 10,
	Enums.Rank.ACE: 11
	}
	
var locationsx = {
	Enums.Rank.ZERO: 0,
	Enums.Rank.ONE: 1,
	Enums.Rank.TWO: 2,
	Enums.Rank.THREE: 3,
	Enums.Rank.FOUR: 4,
	Enums.Rank.FIVE: 5,
	Enums.Rank.SIX: 6,
	Enums.Rank.SEVEN: 7,
	Enums.Rank.EIGHT: 8,
	Enums.Rank.NINE: 9,
	Enums.Rank.TEN: 10,
	Enums.Rank.ELEVEN: 11,
	Enums.Rank.JACK: 12,
	Enums.Rank.QUEEN: 13,
	Enums.Rank.KING: 14,
	Enums.Rank.ACE: 15
}

var locationsy = {
	Enums.Suit.HEARTS : 0,
	Enums.Suit.SPADES: 1,
	Enums.Suit.CLUBS: 2,
	Enums.Suit.DIAMONDS: 3,
	Enums.Suit.STARS: 4,
	Enums.Suit.ALL: 5,
	Enums.Suit.NONE: 6
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
	Enums.Suit.HEARTS : "hearts",
	Enums.Suit.SPADES : "spades",
	Enums.Suit.DIAMONDS : "diamonds",
	Enums.Suit.CLUBS : "clubs"
}

var triggers = 1
var rank = Enums.Rank.ZERO
var suit = Enums.Suit.NONE
var enchantment = Enums.Edition.NORMAL
var rarity = Enums.Rarity.COMMON
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
		Enums.Edition.CURSED:
			$"card base".material.set_shader_parameter("cursed", true)
		Enums.Edition.NORMAL:
			pass
	match rarity:
		Enums.Rarity.RARE:
			$TextureRect.material.set_shader_parameter("rare",true)
			$"card base".material.set_shader_parameter("rare",true)
		Enums.Rarity.SHADOWRARE:
			$"card base".material.set_shader_parameter("shadow", true)
		Enums.Rarity.GOLDENRARE:
			$"card base".material.set_shader_parameter("gold", true)
		Enums.Rarity.COMMON:
			pass
	$Card_graphics.cardReference = self
	$Card_graphics._updateSymbols(rank, suit)
			
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
	if rank == Enums.Rank.ACE:
		return 11
	return _worth()

func _isAce() -> bool:
	return rank == Enums.Rank.ACE

func _isFaceCard() -> bool:
	return rank == Enums.Rank.JACK || rank == Enums.Rank.QUEEN || rank == Enums.Rank.KING

func _hasRarityEffect() -> bool:
	return rarity == Enums.Rarity.UNCOMMON || rarity == Enums.Rarity.RARE || rarity == Enums.Rarity.SOULRARE || Enums.Rarity.ULTRARARE

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
	b._createCard()
	EventBus.cardAdded.emit(self)
