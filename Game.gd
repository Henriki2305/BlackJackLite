class_name Game extends Node2D

var souls = 4
var playerDeck
var opponentDeck : deck
var SoulPowerNew : Scoring = Scoring.new()
var HandPowerNew : Scoring = Scoring.new()
var MultiplierNew : Scoring = Scoring.new()
var TotalPowerNew : Scoring = Scoring.new()
var OpponentScoring : Scoring = Scoring.new()
var SoulPower = 0
var HandPower = 0
var Multiplier = 1
var MemoriesMax = 5
var MaxSouls = 1
var MajorSouls = 0
var TotalPower = 0
var LikeliHoodModifier = 1
var a : float = 0.1
var e = 0.0
var playerBust = 21
var dealerBust = 21
var playPhase = true
var mb: memory_box
var hb: handbox
var AllHands = ["pair", "BlackJack","normal","lovelyFaces","neutrality","27","none",]
var AvailableHands = ["pair","BlackJack","normal","none"]
var choices = ["hit","stand","discard","doubleDown","surrender","burn","clone"]
var CurrentHand = "none"
var MemoriesInGame : Array[String] = ["HelpingHand","SlotMachine","Humility","Skepticism","Credulity","x"]
var roundsPassed = 0
var level = 1
var unlockedCardRanks : Array[String] = ["2","3","4","5","6","7","8","9","10","j","q","k","a"]
var unlockedSuits : Array[String] = ["h","s","d","c"]
var unlockedEnchantments : Array[String] = ["no","cu"]
var BetweenRoundsScene = preload("res://BetweenRound.tscn")
var BurnerScene = preload("res://Scenes/burner.tscn")
var CardListScene = preload("res://Scenes/card_list.tscn")
var listScene = preload("res://Scenes/card_list.tscn")
var chosenCards : Array[card]
var reward = 3
var opponentDeckMultiplier = 0.4
var opponentPower = 0
var ripple : bool = false
var layerLevel = 0
var layer = ""
var currentSouls : Array[soul]
var clist : cardlist


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
#	"normalDeck" : "nohsh7.cuhco7.cuhsh7.nohco7.nodra7.nocco7.nodco7.nohcoa.nohco7.nosco7.nohco7",
	"normalDeck" : "nohsh7.nohgo7.nohsh7.nohgo7.nodra7.nocco7.nodco7.nohcoa.nohco7.nosco7.nohco7",
	"opposingDeck" : "nohcoa.nohco2.nohco3.nohco4.nohco5.nohco6.nohco7.nohco8.nohco9.nohco10.nohcoj.nohcoq.nohcok"
}

func _recruitSoul(s : soul) -> void:
	currentSouls.append(s)
	add_child(s)
	soulRules[s._buySoul()] = true
	s.g = self

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
	_updateHand()

func _getUnlockedRanks() -> Array[String]:
	return unlockedCardRanks
	
func _unlockRank(r : String) -> void:
	unlockedCardRanks.append(r)

func _discardCard() -> void:
	playerDeck._discardCard()
	$CardValueTotal.text = str(playerDeck._cardValuesSum())
	_updateHand()

func _updateSoulShards() -> void:
	$SoulsCounter.text = str(souls)
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property($SoulTrackerPurple,"scale:y", souls*0.1,0.4)
	tween2.tween_property($SoulTrackerPurple,"global_position", Vector2(1850,1045-(souls*2.5)),0.4)

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
		OpponentScoring._setVal(opponentDeck._cardValuesSum(),0)
		$CardValueTotal2.text = str(opponentDeck._cardValuesSum())
		OpponentScoring._MultiplyByNum(opponentDeckMultiplier)
		$OpponentScore.text = str("Score to beat: [color=#0000FF]",OpponentScoring._IntoText(),"[/color]")
		if len(opponentDeck.cardsInHand) > 1 && opponentDeck._cardValuesSum() == 0:
			break
	OpponentScoring._AddNum(pow(layerLevel,3)*(4+level))
	$OpponentScore.text = str("Score to beat: [color=#0000FF]",OpponentScoring._IntoText(),"[/color]")
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
	for h in hb.hands:
		if h._checkReq(playerDeck._getCardsInHand()):
			var tween = get_tree().create_tween()
			var mTween = get_tree().create_tween()
			var cs = h.transform.get_scale()
			tween.tween_property(h,"rotation_degrees", 15,0.02)
			tween.tween_property(h,"rotation_degrees", -15,0.04)
			tween.tween_property(h,"rotation_degrees", 0,0.02)
			mTween.tween_property(h,"scale",cs*1.2,0.02)
			mTween.tween_property(h,"scale",cs,0.03)
			h._effect()
			await get_tree().create_timer(2).timeout
	_updateSoulShards()
	if !playerDeck.bust:
		for c in playerDeck.cardsInHand:
			if c.rarity == Enums.shadowRare:
				c._increaseTriggers(2)
			for i in range(c._getTriggers()):
				_increaseHandPower(c._worth())
				var ttween = get_tree().create_tween()
				if c.enchantment != Enums.normal:
					c._enchantmentEffect()
					ttween.tween_property(c,"rotation_degrees", 15,0.02)
					ttween.tween_property(c,"rotation_degrees", -15,0.04)
					ttween.tween_property(c,"rotation_degrees", 0,0.02)
					await get_tree().create_timer(0.2).timeout
				ttween.tween_property(c,"rotation_degrees", 15,0.02)
				ttween.tween_property(c,"rotation_degrees", -15,0.04)
				ttween.tween_property(c,"rotation_degrees", 0,0.02)
				await get_tree().create_timer(0.2).timeout
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
				await get_tree().create_timer(1).timeout
	for m in mb.Memories:
		if(m._getType() == "normal" || m._getType() == "hybrid"):
			if m._memoryTrigger():
				m._memoryEffect()
				var cs = m.transform.get_scale()
				var mTween = get_tree().create_tween()
				mTween.tween_property(m,"scale",cs*1.2,0.02)
				mTween.tween_property(m,"scale",cs,0.03)
				await get_tree().create_timer(1).timeout
	if(OpponentScoring._GreaterThan(TotalPowerNew)):
		print("you lost!")
		_addToSouls(Global.bet)
	else:
		print("you won!")
		roundsPassed += 1
		reward+=1
		opponentDeckMultiplier*=1.1
		playPhase = true
		if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(2)):
			reward+=1
		if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(10)):
			reward+=1
		if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(50)):
			reward+=1
		if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(1000)):
			reward+=3
	await get_tree().create_timer(2.5).timeout
	Global.bet = 0
	playerDeck._clearHand()
	opponentDeck._clearHand()
	_updateHand()
	_updateSoulPower(0,0)
	_updateHandPower(0,0)
	_updatemultiplier(1,0)
	$increase.visible = true
	$decrease.visible = true
	$placebet.visible = true
	opponentPower = 0
	$OpponentScore.text = str("Score to beat: [color=#0000FF]0[/color]")
	if roundsPassed == 3:
		roundsPassed = 0
		_addToSouls(reward)
		reward=3
		_betweenRounds()
	
func _betweenRounds() -> void:
	$increase.visible = false
	$decrease.visible = false
	$placebet.visible = false
	$SoulPowerText.visible = false
	$HandPowerText.visible = false
	$MultiplierText.visible = false
	$TotalPowerText.visible = false
	if level == 3:
		var burneri = BurnerScene.instantiate()
		burneri.set_name("burner")
		add_child(burneri)
		burneri.global_position = Vector2(0,0)
	else:
		var betweenRounds = BetweenRoundsScene.instantiate()
		betweenRounds.set_name("betweenRounds")
		add_child(betweenRounds)
		betweenRounds.global_position = Vector2(700,400)
	playerDeck._restoreDeck()
	opponentDeck._restoreDeck()
	
func _advance() -> void:
	level+=1
	$increase.visible = true
	$decrease.visible = true
	$placebet.visible = true
	$SoulPowerText.visible = true
	$HandPowerText.visible = true
	$MultiplierText.visible = true
	$TotalPowerText.visible = true

func _increase() -> void:
	if Global.bet < souls:
		Global.bet += 1

func _decrease() -> void:
	if Global.bet > Global.minii:
		Global.bet -=1


func _placeBet() -> void:
	_updateSoulPower(Global.bet,0)
	$increase.visible = false
	$decrease.visible = false
	$placebet.visible = false
	_drawDealerHand()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HandPowerNew.Vals = [0.0,0]
	SoulPowerNew.Vals = [0.0,0]
	MultiplierNew.Vals = [1.0,0]
	TotalPowerNew.Vals = [0.0,0]
	OpponentScoring.Vals = [0.0,0]
	playerDeck = $Deck
	opponentDeck = $OpponentsDeck
	mb = $MemoryBox
	hb = $hand_box
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
	HitButton.position = Vector2(900,1000)
	HitButton.pressed.connect(_drawcard)
	HitButton.name = "hitButton"
	StandButton.position = Vector2(950,1000)
	StandButton.pressed.connect(_playHand)
	StandButton.name = "standButton"
	DiscardButton.position = Vector2(1000,1000)
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
	Increasebutton.position = Vector2(700,1000)
	Decreasebutton.position = Vector2(800,1000)
	PlaceBetButton.position = Vector2(900,1000)
	$SoulPowerText.text = "Soulpower: 0"
	$HandPowerText.text = "HandPower: 0"
	$MultiplierText.text = "Multiplier: 1"
	$TotalPowerText.text = "Total power: 0"
	$ColorRect.material.set_shader_parameter("width",0.0)
	$ColorRect.material.set_shader_parameter("spot",0.0)
	_updateSoulShards()
	
func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ripple:
		var s = $ColorRect.material.get_shader_parameter("spot")
		if s > 0.50:
			$ColorRect.material.set_shader_parameter("spot",0.0)
			$ColorRect.material.set_shader_parameter("width",0.0)
			ripple = false
		else:
			$ColorRect.material.set_shader_parameter("spot", s+0.005)

func _addToSouls(i : int) -> void:
	souls += i
	_updateSoulShards()

func _updateHand() -> void:
	var cards : Array[card] = playerDeck._getCardsInHand()
	for h in hb.hands:
		if h._checkReq(cards):
			h._setTrigger(true)
		else:
			h._setTrigger(false)
	
func _increaseHandPower(amount) -> void:
	HandPowerNew._AddNum(amount)
	_updatePower()
	
func _increaseSoulPower(amount) -> void:
	SoulPowerNew._AddNum(amount)
	_updatePower()
	
func _increasemultiplier(amount) -> void:
	MultiplierNew._AddNum(amount)
	_updatePower()
	
func _multiplyHandPower(amount) -> void:
	_updateHandPower(HandPowerNew.Vals[0]*amount,HandPowerNew.Vals[1])
	
func _multiplySoulPower(amount) -> void:
	_updateSoulPower(SoulPowerNew.Vals[0]*amount,SoulPowerNew.Vals[1])
	
func _multiplyMultiplier(amount) -> void:
	_updatemultiplier(MultiplierNew.Vals[0]*amount,MultiplierNew.Vals[1])
	
func _multiplyMultiplierbyPercent(amount) -> void:
	MultiplierNew.Vals = MultiplierNew._ValMult(MultiplierNew._MultipliedByNum(amount).vals,MultiplierNew.Vals)
	
func _updateHandPower(amount,b) -> void:
	HandPowerNew._setVal(amount,b)
	$HandPowerText.text = str("Handpower: ",HandPowerNew._IntoText())
	_updatePower()

func _updateSoulPower(amount,b) -> void:
	SoulPowerNew._setVal(amount,b)
	$SoulPowerText.text = str("Soulpower: ", SoulPowerNew._IntoText())
	_updatePower()

func _updatemultiplier(amount,b) -> void:
	MultiplierNew._setVal(amount,b)
	$HandPowerText.text = str("Handpower: ",HandPowerNew._IntoText())
	_updatePower()
	
func _updatePower() -> void:
	$HandPowerText.text = str("Handpower: ",HandPowerNew._IntoText())
	$SoulPowerText.text = str("Soulpower: ", SoulPowerNew._IntoText())
	$MultiplierText.text = str("Multiplier: ",MultiplierNew._IntoText())
	TotalPowerNew.Vals = TotalPowerNew._ValMult(SoulPowerNew.Vals,TotalPowerNew._ValMult(HandPowerNew.Vals,MultiplierNew.Vals))
	TotalPowerNew._updateValue()
	$TotalPowerText.text = str("Total power: ", TotalPowerNew._IntoText())
#	if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(10)):
#		$ColorRect.material.set_shader_parameter("width",0.0125)
#		$ColorRect.material.set_shader_parameter("spot",0.03)
#		ripple = true

func _createList() -> void:
	if clist == null:
		clist = listScene.instantiate()
		$Control.add_child(clist)
	
func _destroyList() -> void:
	if clist:
		$Control.remove_child(clist)
		clist.queue_free()
		clist = null
