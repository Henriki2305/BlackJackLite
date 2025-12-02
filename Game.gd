class_name Game extends Node2D

var souls = 4
var playerDeck
var opponentDeck
var SoulPower = 0
var HandPower = 0
var Multiplier = 1
var MemoriesMax = 5
var Memories = [$Mslot_machine]
var MaxSouls = 2
var MajorSouls = 0
var TotalPower = 0
var AvailableHands = ["pair","BlackJack","normal","none"]
var CurrentHand = "none"
var MemoriesInGame : Array[memory] = []

var DeckStrings : Dictionary = {
	"normalDeck" : "noha.noh2.noh3.noha.nod10.noc7.noda.noha.noha.nosa.nohj",
	"opposingDeck" : "noha.noh2.noh3.noh4.noh5.noh6.noh7.noh8.noh9.noh10.nohj.nohq.nohk"
}

var HandPowers = {
	"normal" = 1,
	"BlackJack" = 1.5,
	"pair" = 2,
	"none" = 0
}

func _determineDeck(GivenDeck) -> String:
	if GivenDeck == $Deck:
		return DeckStrings["normalDeck"]
	if GivenDeck == $OpponentsDeck:
		return DeckStrings["opposingDeck"]
	return ""

func _drawcard() -> void:
	playerDeck._drawCard()
	$CardValueTotal.text = str(playerDeck._cardValuesSum())
	for hand in AvailableHands:
		if playerDeck._hasHand(hand):
			print(hand)
			_updateHand(hand)
			break

func _playHand() -> void:
	$hitButton.visible = false
	$standButton.visible = false
	while opponentDeck._cardValuesSum() < 17:
		await get_tree().create_timer(1.5).timeout
		opponentDeck._drawCard()
		$CardValueTotal2.text = str(opponentDeck._cardValuesSum())
	await get_tree().create_timer(0.85).timeout
	print(str("opponent's hand: ", opponentDeck._cardValuesSum()))
	print(str("opponent's score: ", opponentDeck._cardValuesSum()*opponentDeck.multiplier))
	for c in playerDeck.cardsInHand:
		for m in Memories:
			if(m.typ == "card" || m.typ == "hybrid"):
				if m._memoryTriggerCard(c):
					m._memoryEffectCard(c)
					await get_tree().create_timer(0.5).timeout
	for m in Memories:
		if(m.typ == "normal" || m.typ == "hybrid"):
			if m._memoryTrigger():
				m._memoryEffect()
				await get_tree().create_timer(1).timeout
	if(opponentDeck._cardValuesSum()*opponentDeck.multiplier > TotalPower):
		print("you lost!")
		souls -= Global.bet
	else:
		print("you won!")
		opponentDeck._increaseMult()
	await get_tree().create_timer(2.5).timeout
	Global.bet = 0
	playerDeck._clearHand()
	opponentDeck._clearHand()
	_updateHand("none")
	_updateSoulPower(0)
	$increase.visible = true
	$decrease.visible = true
	$placebet.visible = true
	

func _increase() -> void:
	if Global.bet < souls:
		Global.bet += 1

func _decrease() -> void:
	if Global.bet > Global.minii:
		Global.bet -=1


func _placeBet() -> void:
	_updateSoulPower(Global.bet)
	$hitButton.visible = true
	$standButton.visible = true
	$increase.visible = false
	$decrease.visible = false
	$placebet.visible = false
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerDeck = $Deck
	opponentDeck = $OpponentsDeck
	var Increasebutton = Button.new()
	var Decreasebutton = Button.new()
	var PlaceBetButton = Button.new()
	var HitButton = Button.new()
	var StandButton = Button.new()
	HitButton.text = "hit"
	StandButton.text = "Stand"
	add_child(HitButton)
	add_child(StandButton)
	HitButton.position = Vector2(400,300)
	HitButton.pressed.connect(_drawcard)
	HitButton.name = "hitButton"
	StandButton.position = Vector2(450,300)
	StandButton.pressed.connect(_playHand)
	StandButton.name = "standButton"
	HitButton.visible = false
	StandButton.visible = false
	Increasebutton.name = "increase"
	Decreasebutton.name = "decrease"
	PlaceBetButton.name = "placebet"
	Increasebutton.text = "increase"
	Decreasebutton.text = "decrease"
	PlaceBetButton.text = "place bet"
	Increasebutton.pressed.connect(_increase)
	Decreasebutton.pressed.connect(_decrease)
	PlaceBetButton.pressed.connect(_placeBet)
	add_child(Increasebutton)
	add_child(Decreasebutton)
	add_child(PlaceBetButton)
	Increasebutton.position = Vector2(200,200)
	Decreasebutton.position = Vector2(300,200)
	PlaceBetButton.position = Vector2(400,200)
	$SoulPowerText.text = "Soulpower: 0"
	$HandPowerText.text = "HandPower: 0"
	$MultiplierText.text = "Multiplier: 0"
	$TotalPowerText.text = "Total power: 0"
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _updateHand(HandName) -> void:
	CurrentHand = HandName
	_updateHandPower(HandPowers[CurrentHand]*playerDeck._cardValuesSum())
	
func _increaseHandPower(amount) -> void:
	_updateHandPower(HandPower + amount)
	
func _increaseSoulPower(amount) -> void:
	_updateSoulPower(SoulPower + amount)
	
func _increasemultiplier(amount) -> void:
	_updatemultiplier(Multiplier + amount)
	
func _multiplyHandPower(amount) -> void:
	_updateHandPower(HandPower*amount)
	
func _multiplySoulPower(amount) -> void:
	_updateSoulPower(SoulPower*amount)
	
func _multiplyMultiplier(amount) -> void:
	_updatemultiplier(Multiplier*amount)
	
func _updateHandPower(amount) -> void:
	HandPower = amount
	$HandPowerText.text = str("Handpower: ",HandPower)
	_updatePower()

func _updateSoulPower(amount) -> void:
	SoulPower = amount
	$SoulPowerText.text = str("Soulpower: ", SoulPower)
	_updatePower()

func _updatemultiplier(amount) -> void:
	Multiplier = amount
	$HandPowerText.text = str("Handpower: ",HandPower)
	_updatePower()
	
func _updatePower() -> void:
	TotalPower = SoulPower*HandPower*Multiplier
	$TotalPowerText.text = str("Total power: ", TotalPower)
