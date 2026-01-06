class_name Game extends Node2D

var souls = 4
var playerDeck
var opponentDeck
var SoulPower = 0
var HandPower = 0
var Multiplier = 1
var MemoriesMax = 5
var MaxSouls = 2
var MajorSouls = 0
var TotalPower = 0
var playPhase = true
var mb: memory_box
var AllHands = ["pair", "BlackJack","normal","lovelyFaces","neutrality","27","none",]
var AvailableHands = ["pair","BlackJack","normal","none"]
var choices = ["hit","stand","discard","doubleDown","surrender","burn","clone"]
var CurrentHand = "none"
var MemoriesInGame : Array[String] = ["HelpingHand","SlotMachine","Humility","Skepticism","Credulity"]
var roundsPassed = 0
var level = 1
var unlockedCardRanks : Array[String] = ["2","3","4","5","6","7","8","9","10","j","q","k","a"]
var unlockedSuits : Array[String] = ["h","s","d","c"]
var unlockedEnchantments : Array[String] = ["no","cu"]
var BetweenRoundsScene = preload("res://BetweenRound.tscn")
var reward = 3
var opponentDeckMultiplier = 0.4
var opponentPower = 0
var ripple : bool = false


var soulRules : Dictionary = {
	"Demented" : false, #memories in store are free but only last 6 rounds
	"Forgiving" : false, #You cannot bust if you fulfill the requirements of at least 1 hand,
	"Vengeful" : false, #Losing a bet gives twice its amount in soul power to your next hand,
	"Eccentric" : false, #You cannot gain bonus soul shards from rounds, at the end of round get a new memory if you have space for it
	"chaotic" : false, #All your memories trigger twice, but have 1 in 2 chance to not trigger at all
	"destructive" : false #After beating third level of a layer, get a round of destruction 
}

var handReqTexts : Dictionary = {
	"testhand1" : "testReq1",
	"testhand2" : "testReq2",
	"testhand3" : "testReq3"
}

var handRewardTexts : Dictionary = {
	"testhand1" : "testRew1",
	"testhand2" : "testRew2",
	"testhand3" : "testRew3"
}

var DeckStrings : Dictionary = {
	"normalDeck" : "nohsh7.cuhco7.cuhsh7.nohco7.nodra7.nocco7.nodco7.nohcoa.nohco7.nosco7.nohco7",
	"opposingDeck" : "nohcoa.nohco2.nohco3.nohco4.nohco5.nohco6.nohco7.nohco8.nohco9.nohco10.nohcoj.nohcoq.nohcok"
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
	return str(unlockedEnchantments.pick_random(),unlockedSuits.pick_random(),"co",unlockedCardRanks.pick_random())

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

func _getMemsInGame() -> Array:
	return MemoriesInGame

func _drawDealerHand() -> void:
	playPhase = false
	$hitButton.visible = false
	$standButton.visible = false
	$discardButton.visible = false
	while opponentDeck._cardValuesSum() < 17:
		await get_tree().create_timer(1.5).timeout
		opponentDeck._drawCard()
		$CardValueTotal2.text = str(opponentDeck._cardValuesSum())
		opponentPower = opponentDeck._cardValuesSum()*opponentDeckMultiplier
		$OpponentScore.text = str("Score to beat: [color=#0000FF]",opponentPower,"[/color]")
	await get_tree().create_timer(0.35).timeout
	playPhase = true
	$hitButton.visible = true
	$standButton.visible = true
	$discardButton.visible = true

func _playHand() -> void:
	playPhase = false
	$hitButton.visible = false
	$standButton.visible = false
	$discardButton.visible = false
	for c in playerDeck.cardsInHand:
		for m in mb._getMemories():
			if(m._getType() == "card" || m._getType() == "hybrid"):
				if m._memoryTriggerCard(c):
					var tween = get_tree().create_tween()
					var mTween = get_tree().create_tween()
					var cs = m.transform.get_scale()
					tween.tween_property(c,"rotation_degrees", 15,0.02)
					tween.tween_property(c,"rotation_degrees", -15,0.04)
					tween.tween_property(c,"rotation_degrees", 0,0.02)
					mTween.tween_property(m,"scale",cs*1.2,0.02)
					mTween.tween_property(m,"scale",cs,0.03)
					m._memoryEffectCard(c)
					await get_tree().create_timer(2).timeout
	for m in mb.Memories:
		if(m._getType() == "normal" || m._getType() == "hybrid"):
			if m._memoryTrigger():
				m._memoryEffect()
				var cs = m.transform.get_scale()
				var mTween = get_tree().create_tween()
				mTween.tween_property(m,"scale",cs*1.2,0.02)
				mTween.tween_property(m,"scale",cs,0.03)
				await get_tree().create_timer(1).timeout
	if(opponentPower > TotalPower):
		print("you lost!")
		souls -= Global.bet
	else:
		print("you won!")
		roundsPassed += 1
		reward+=1
		opponentDeckMultiplier*=1.1
		playPhase = true
		if TotalPower > 2*opponentPower:
			reward+=1
		if TotalPower > 10*opponentPower:
			reward+=1
		if TotalPower > 50*opponentPower:
			reward+=1
		if TotalPower > 1000*opponentPower:
			reward+=3
	await get_tree().create_timer(2.5).timeout
	Global.bet = 0
	playerDeck._clearHand()
	opponentDeck._clearHand()
	_updateHand("none")
	_updateSoulPower(0)
	$increase.visible = true
	$decrease.visible = true
	$placebet.visible = true
	opponentPower = 0
	$OpponentScore.text = str("Score to beat: [color=#0000FF]0[/color]")
	if roundsPassed == 3:
		roundsPassed = 0
		souls+=reward
		reward=3
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
	$betweenRounds.queue_free()

func _increase() -> void:
	if Global.bet < souls:
		Global.bet += 1

func _decrease() -> void:
	if Global.bet > Global.minii:
		Global.bet -=1


func _placeBet() -> void:
	_updateSoulPower(Global.bet)
	$increase.visible = false
	$decrease.visible = false
	$placebet.visible = false
	_drawDealerHand()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerDeck = $Deck
	opponentDeck = $OpponentsDeck
	mb = $MemoryBox
	playerDeck._setSide(false)
	opponentDeck._setSide(true)
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
	HitButton.position = Vector2(900,700)
	HitButton.pressed.connect(_drawcard)
	HitButton.name = "hitButton"
	StandButton.position = Vector2(950,700)
	StandButton.pressed.connect(_playHand)
	StandButton.name = "standButton"
	DiscardButton.position = Vector2(1000,700)
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
	Increasebutton.position = Vector2(700,600)
	Decreasebutton.position = Vector2(800,600)
	PlaceBetButton.position = Vector2(900,600)
	$SoulPowerText.text = "Soulpower: 0"
	$HandPowerText.text = "HandPower: 0"
	$MultiplierText.text = "Multiplier: 1"
	$TotalPowerText.text = "Total power: 0"
	$ColorRect.material.set_shader_parameter("width",0.0)
	$ColorRect.material.set_shader_parameter("spot",0.0)
	
func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ripple:
		var s = $ColorRect.material.get_shader_parameter("spot")
		if s > 0.50:
			$ColorRect.material.set_shader_parameter("spot",0.0)
			$ColorRect.material.set_shader_parameter("width",0.0)
			ripple = false
		else:
			$ColorRect.material.set_shader_parameter("spot", s+0.005)

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
	#if TotalPower > 10*opponentPower:
	#	$ColorRect.material.set_shader_parameter("width",0.0125)
	#	$ColorRect.material.set_shader_parameter("spot",0.03)
	#	ripple = true
