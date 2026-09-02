class_name Game extends Node2D

var souls = 4
var playerDeck
var opponentDeck : deck

var notationLimit : BigNumber = BigNumber.new()
var MemoriesMax = 5
var MaxSouls = 1
var MajorSouls = 0
var TotalPower = 0
var LikeliHoodModifier = 1
var playerBust = 21
var playPhase = true
var roundsPassed = 0
var level = 1
var unlockedCardRanks : Array[String] = ["2","3","4","5","6","7","8","9","10","j","q","k","a"]
var unlockedSuits : Array[String] = ["h","s","d","c"]
var unlockedEnchantments : Array[String] = ["no","cu"]
var BetweenRoundsScene = preload("res://BetweenRound.tscn")
var BurnerScene = preload("res://Scenes/burner.tscn")
var CardListScene = preload("res://Scenes/card_list.tscn")
var chosenCards : Array[card]
var reward = 3
var beatLevels = 0
var opponentDeckMultiplier = 0.4
var opponentPower = 0
var ripple : bool = false
var layerLevel = 0
var layer = "start"
var boonLevel = 0
var currentSouls : Array[soul]
var clist : cardlist
var LayerScores = [20,100,400,1200,3000,6000,10000,20000]
var LayerMults = [1,4,15,50,100,200,350,500]
var layers : Array[String] = ["lust","gluttony","pride","greed","sloth","wrath","envy"]
var bossRound : bool = false
var Emode : bool = true


var soulRules : Dictionary = {
	"Demented" : false, #memories in store are free but only last 6 rounds
	"Forgiving" : false, #You cannot bust if you fulfill the requirements of at least 1 hand,
	"Vengeful" : false, #Losing a bet gives twice its amount in soul power to your next hand,
	"Eccentric" : false, #You cannot gain bonus soul shards from rounds, at the end of round get a new memory if you have space for it
	"Chaotic" : false, #All your memories trigger twice, but have 1 in 2 chance to not trigger at all
	"Destructive" : false, #After beating third level of a layer, get a round of destruction
	"Thieving" : false, #First purchase of every store is free
	"Spiritual" : false, #All soulpower effects are 20% more efficient
	"Content" : false, #machines do not trigger their card pair effects
	"Resourceful" : false, #cost of pressing buttons is halved
	"Experienced" : false, #triggering a hand 10 times levels up one of its traits
}

var handReqTexts : Dictionary = {
	"testhand1" : "testReq1",
	"testhand2" : "testReq2",
	"testhand3" : "testReq3"
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
	s.global_position = Vector2(400,880)
	
#func _hasSoul(s : String) -> bool:
#	return soulRules[s]
#
#func _getPlayerDeck() -> deck:
#	return playerDeck
#
#func _getRandomCard() -> String:
#	return str(unlockedEnchantments.pick_random(),unlockedSuits.pick_random(),"co",unlockedCardRanks.pick_random())
#
#func _determineDeck(GivenDeck) -> String:
#	if GivenDeck == $Deck:
#		return DeckStrings["normalDeck"]
#	if GivenDeck == $OpponentsDeck:
#		return DeckStrings["opposingDeck"]
#	return ""
#
#func _getUnlockedRanks() -> Array[String]:
#	return unlockedCardRanks
#	
#func _unlockRank(r : String) -> void:
#	unlockedCardRanks.append(r)
#
##func _drawDealerHand() -> void:
##	playPhase = false
##	_hidePlayButtons()
##	while opponentDeck._cardValuesSum() < 17:
##		await get_tree().create_timer(1.5).timeout
##		opponentDeck._drawCard()
##		OpponentScoring._setVal((LayerScores[layerLevel]+LayerMults[layerLevel]*opponentDeck._cardValuesSum())*(1+(beatLevels*0.1)),0)
##		$CardValueTotal2.text = str(opponentDeck._cardValuesSum())
##		$OpponentScore.text = str("Score to beat: [color=#0000FF]",OpponentScoring._IntoText(),"[/color]")
##		if len(opponentDeck.cardsInHand) > 1 && opponentDeck._cardValuesSum() == 0:
##			break
##	OpponentScoring._AddNum(pow(layerLevel,3)*(4+level))
##	$OpponentScore.text = str("Score to beat: [color=#0000FF]",OpponentScoring._IntoText(),"[/color]")
##	await get_tree().create_timer(0.35).timeout
##	playPhase = true
##	_showPlayButtons()
#
#func _playHand() -> void:
#	playPhase = false
#	_hidePlayButtons()
#	for h in hb.hands:
#		if h._checkReq(playerDeck._getCardsInHand()):
#			var tween = get_tree().create_tween()
#			var mTween = get_tree().create_tween()
#			var cs = h.transform.get_scale()
#			tween.tween_property(h,"rotation_degrees", 15,0.02)
#			tween.tween_property(h,"rotation_degrees", -15,0.04)
#			tween.tween_property(h,"rotation_degrees", 0,0.02)
#			mTween.tween_property(h,"scale",cs*1.2,0.02)
#			mTween.tween_property(h,"scale",cs,0.03)
#			h._effect()
#			await get_tree().create_timer(2).timeout
#	_updateSoulShards()
#	if !playerDeck.bust:
#		for c in playerDeck.cardsInHand:
#			if c.rarity == Enums.shadowRare:
#				c._increaseTriggers(2)
#			for i in range(c._getTriggers()):
#				_increaseHandPower(c._worth())
#				var ttween = get_tree().create_tween()
#				if c.enchantment != Enums.normal:
#					c._enchantmentEffect()
#					ttween.tween_property(c,"rotation_degrees", 15,0.02)
#					ttween.tween_property(c,"rotation_degrees", -15,0.04)
#					ttween.tween_property(c,"rotation_degrees", 0,0.02)
#					await get_tree().create_timer(0.2).timeout
#				ttween.tween_property(c,"rotation_degrees", 15,0.02)
#				ttween.tween_property(c,"rotation_degrees", -15,0.04)
#				ttween.tween_property(c,"rotation_degrees", 0,0.02)
#				await get_tree().create_timer(0.2).timeout
#				for m in mb._getMemories():
#					if(m._getType() == "card" || m._getType() == "hybrid"):
#						if m._memoryTriggerCard(c):
#							var tween = get_tree().create_tween()
#							var mTween = get_tree().create_tween()
#							var cs = m.transform.get_scale()
#							tween.tween_property(c,"rotation_degrees", 15,0.02)
#							tween.tween_property(c,"rotation_degrees", -15,0.04)
#							tween.tween_property(c,"rotation_degrees", 0,0.02)
#							mTween.tween_property(m,"scale",cs*1.2,0.02)
#							mTween.tween_property(m,"scale",cs,0.03)
#							m._memoryEffectCard(c)
#							await get_tree().create_timer(2).timeout
#				await get_tree().create_timer(1).timeout
#	for m in mb.Memories:
#		if(m._getType() == "normal" || m._getType() == "hybrid"):
#			if m._memoryTrigger():
#				m._memoryEffect()
#				var cs = m.transform.get_scale()
#				var mTween = get_tree().create_tween()
#				mTween.tween_property(m,"scale",cs*1.2,0.02)
#				mTween.tween_property(m,"scale",cs,0.03)
#				await get_tree().create_timer(1).timeout
#	if(OpponentScoring._GreaterThan(TotalPowerNew)):
#		print("you lost!")
#		_addToSouls(Global.bet)
#	else:
#		print("you won!")
#		roundsPassed += 1
#		reward+=1
#		opponentDeckMultiplier*=1.1
#		playPhase = true
#		if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(2)):
#			reward+=1
#		if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(10)):
#			reward+=1
#		if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(50)):
#			reward+=1
#		if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(1000)):
#			reward+=3
#	await get_tree().create_timer(2.5).timeout
#	Global.bet = 0
#	playerDeck._clearHand()
#	opponentDeck._clearHand()
#	opponentPower = 0
#	$OpponentScore.text = str("Score to beat: [color=#0000FF]0[/color]")
#	if roundsPassed == 3:
#		roundsPassed = 0
#		_addToSouls(reward)
#		reward=3
#		_betweenRounds()
	
func _betweenRounds() -> void:
	if level == 3:
		var burneri = BurnerScene.instantiate()
		burneri.set_name("burner")
		add_child(burneri)
		burneri.global_position = Vector2(0,0)
	else:
		var betweenRounds = BetweenRoundsScene.instantiate()
		betweenRounds.set_name("betweenRounds")
		add_child(betweenRounds)
		betweenRounds.global_position = Vector2(0,0)
	playerDeck._restoreDeck()
	opponentDeck._restoreDeck()
	$Sprite2D2.hide()
	$Sprite2D3.hide()
	
func _advance() -> void:
	level+=1
	$SoulPowerText.visible = true
	$HandPowerText.visible = true
	$MultiplierText.visible = true
	$TotalPowerText.visible = true
	$Sprite2D2.show()
	$Sprite2D3.show()

func _increase() -> void:
	if Global.bet < souls:
		Global.bet += 1

func _decrease() -> void:
	if Global.bet > Global.minii:
		Global.bet -=1
	
func _curse() -> void:
	boonLevel = 1
	_nextLayer()
	
func _aura() -> void:
	var price = 5 + 10*layerLevel
	if(souls >= price):
#		_addToSouls(-price)
		boonLevel = 2
	_nextLayer()
	
func _boon() -> void:
	var price = 10 + 20*layerLevel
	if(souls >= price):
#		_addToSouls(-price)
		boonLevel = 3
	_nextLayer()
	
func _nextLayer() -> void:
	layerLevel+=1
	layer = layers[layerLevel]
	$LayerNameText.text=layer
	$LayerGate.hide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	notationLimit.mantissa=1
	notationLimit.exponent=9
	layers.shuffle()
	layers.append(layers[0])
	layers[0] = "start"
	layers.append("final")
	$LayerGate.aura.connect(_aura)
	$LayerGate.boon.connect(_boon)
	$LayerGate.curse.connect(_curse)
	playerDeck = $Deck
	$LayerNameText.text=layer
	playerDeck._setSide(false)
	$ColorRect.material.set_shader_parameter("width",0.0)
	$ColorRect.material.set_shader_parameter("spot",0.0)
	
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
			$ColorRect.material.set_shader_parameter("spot", s+_delta*0.5)
	

func _createList() -> void:
	if clist == null:
		clist = CardListScene.instantiate()
		$Control2/Control.add_child(clist)
	
func _destroyList() -> void:
	if clist:
		$Control2/Control.remove_child(clist)
		clist.queue_free()
		clist = null
		
