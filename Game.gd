class_name Game extends Node2D

var souls = 4
var playerDeck
var opponentDeck : deck

var MemoriesMax = 5
var MaxSouls = 1
var MajorSouls = 0
var TotalPower = 0
var LikeliHoodModifier = 1
var playPhase = true
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
	
func _betweenRounds(_n : BigNumber) -> void:
	if level == 3:
		var burneri = BurnerScene.instantiate()
		burneri.set_name("burner")
		add_child(burneri)
		burneri.global_position = Vector2(0,0)
	else:
		$BetweenRound.show()
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
	EventBus.roundWon.connect(_betweenRounds)
	
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
