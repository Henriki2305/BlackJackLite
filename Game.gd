class_name Game extends Node2D

var souls = 4
var playerDeck
var opponentDeck
var SoulPower = 0
var HandPower = 0
var Multiplier = 1
var MemoriesMax = 5
var Memories = []
var MaxSouls = 2
var MajorSouls = 0
var TotalPower = 0
var AllHands = ["pair", "BlackJack","normal","lovelyFaces","neutrality","27","none",]
var AvailableHands = ["pair","BlackJack","normal","none"]
var choices = ["hit","stand","discard","doubleDown","surrender","burn","clone"]
var CurrentHand = "none"
var MemoriesInGame : Array[memory] = []
var roundsPassed = 0
var level = 1
var unlockedCardRanks : Array[String] = ["2","3","4","5","6","7","8","9","10","j","q","k","a"]
var unlockedSuits : Array[String] = ["h","s","d","c"]
var unlockedEnchantments : Array[String] = ["no","cu"]
var  BetweenRoundsScene = preload("res://BetweenRound.tscn")

var DeckStrings : Dictionary = {
	"normalDeck" : "noh7.noh7.noh7.noh7.nod7.noc7.nod7.noha.noh7.nos7.noh7",
	"opposingDeck" : "noha.noh2.noh3.noh4.noh5.noh6.noh7.noh8.noh9.noh10.nohj.nohq.nohk"
}

var HandPowers = {
	"normal" = 1,
	"BlackJack" = 1.5,
	"pair" = 2,
	"none" = 0
}

func _getPlayerDeck() -> deck:
	return playerDeck

func _getRandomCard() -> String:
	return str(unlockedEnchantments.pick_random(),unlockedSuits.pick_random(),unlockedCardRanks.pick_random())

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

func _getUnlockedRanks() -> Array[String]:
	return unlockedCardRanks
	
func _unlockRank(r : String) -> void:
	unlockedCardRanks.append(r)

func _discardCard() -> void:
	playerDeck._discardCard()
	$CardValueTotal.text = str(playerDeck._cardValuesSum())
	for hand in AvailableHands:
		if playerDeck._hasHand(hand):
			print(hand)
			_updateHand(hand)
			break

func _playHand() -> void:
	$hitButton.visible = false
	$standButton.visible = false
	$discardButton.visible = false
	while opponentDeck._cardValuesSum() < 17:
		await get_tree().create_timer(1.5).timeout
		opponentDeck._drawCard()
		$CardValueTotal2.text = str(opponentDeck._cardValuesSum())
	await get_tree().create_timer(0.85).timeout
	var opponentDeckMultiplier = 0.4
	print(str("opponent's hand: ", opponentDeck._cardValuesSum()))
	print(str("opponent's score: ", opponentDeck._cardValuesSum()*opponentDeckMultiplier))
	for c in playerDeck.cardsInHand:
		for m in Memories:
			if(m._GetType() == "card" || m._GetType() == "hybrid"):
				if m._memoryTriggerCard(c):
					var tween = get_tree().create_tween()
					tween.tween_property(c,"rotation_degrees", 15,0.02)
					tween.tween_property(c,"rotation_degrees", -15,0.04)
					tween.tween_property(c,"rotation_degrees", 0,0.02)
					m._memoryEffectCard(c)
					await get_tree().create_timer(2).timeout
	for m in Memories:
		if(m._GetType() == "normal" || m._GetType() == "hybrid"):
			if m._memoryTrigger():
				m._memoryEffect()
				await get_tree().create_timer(1).timeout
	if(opponentDeck._cardValuesSum()*opponentDeckMultiplier > TotalPower):
		print("you lost!")
		souls -= Global.bet
	else:
		print("you won!")
		roundsPassed += 1
	await get_tree().create_timer(2.5).timeout
	Global.bet = 0
	playerDeck._clearHand()
	opponentDeck._clearHand()
	_updateHand("none")
	_updateSoulPower(0)
	$increase.visible = true
	$decrease.visible = true
	$placebet.visible = true
	if roundsPassed == 3:
		roundsPassed = 0
		_betweenRounds()
	
func _betweenRounds() -> void:
	$increase.visible = false
	$decrease.visible = false
	$placebet.visible = false
	var betweenRounds = BetweenRoundsScene.instantiate()
	betweenRounds.set_name("betweenRounds")
	add_child(betweenRounds)
	betweenRounds.position = Vector2(0,0)
	playerDeck._restoreDeck()
	opponentDeck._restoreDeck()
	
func _advance() -> void:
	level+=1
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
	$discardButton.visible = true
	$increase.visible = false
	$decrease.visible = false
	$placebet.visible = false
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerDeck = $Deck
	opponentDeck = $OpponentsDeck
	Memories.append($Mslot_machine)
	MemoriesInGame.append($Mslot_machine)
	var Increasebutton = Button.new()
	var Decreasebutton = Button.new()
	var PlaceBetButton = Button.new()
	var HitButton = Button.new()
	var StandButton = Button.new()
	var DiscardButton = Button.new()
	HitButton.text = "hit"
	StandButton.text = "Stand"
	DiscardButton.text = "Discard"
	add_child(HitButton)
	add_child(StandButton)
	add_child(DiscardButton)
	HitButton.position = Vector2(400,300)
	HitButton.pressed.connect(_drawcard)
	HitButton.name = "hitButton"
	StandButton.position = Vector2(450,300)
	StandButton.pressed.connect(_playHand)
	StandButton.name = "standButton"
	DiscardButton.position = Vector2(500,300)
	DiscardButton.pressed.connect(_discardCard)
	DiscardButton.name = "discardButton"
	HitButton.visible = false
	StandButton.visible = false
	DiscardButton.visible = false
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
	$MultiplierText.text = "Multiplier: 1"
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
