class_name memory extends Node2D

var triggerType : String #card, normal, hybrid, none

var memPos : int = 0
var memInfo : String = ""
var memName : String = ""
var Dat1
var Dat2
var psoulP
var msoulP
var phandP
var mhandP
var pmult
var mmult
var mpower
var g: Game
var box: memory_box
var inStore = false
var price : int = 0
@export var memoryStats : memoryData
var Prices : Dictionary = {
	"HelpingHand" : 3,
	"SlotMachine" : 5,
	"Humility" : 5,
	"Skepticism" : 5,
	"Credulity" : 5,
	"x" : 6
}

func _hasInstantEffect() -> bool:
	return false
	
func _hasPerCardEffect() -> bool:
	return false

func _hasPassiveEffect() -> bool:
	return false

func _setBox(b:memory_box) -> void:
	box = b

func upModText() -> void:
	var tex : String = ""
	if psoulP != null:
		tex = str("[color=#FF00FF]+",psoulP,"soul power[/color]")
	if msoulP != null:
		tex = str("[color=#FF00FF]x",msoulP,"soul power[/color]")
	if phandP != null:
		tex = str("[color=#FF0000]+",phandP,"hand power[/color]")
	if mhandP != null:
		tex = str("[color=#FF0000]x",mhandP,"hand power[/color]")
	if pmult != null:
		tex = str("[color=#0000FF]+",pmult,"multiplier[/color]")
	if mmult != null:
		tex = str("[color=#0000FF]x",mmult,"multiplier[/color]")
	if mpower != null:
		tex = str("[color=#00FF00]+",mpower,"power of multiplier[/color]")	
	$modifierText.text = tex

func _buyMemory() -> void:
	if g._hasSoul("thieving") && g.currentSouls[0]._getValue() == 1:
		g.currentSouls[0]._setValue(0)
		$BuyButton.hide()
		inStore = false
		get_parent().remove_child(self)
		g.mb._addMemory(self)
		_memoryEffectAdded()	
	else:
		if g.souls >= price:
			$BuyButton.hide()
			g._addToSouls(-price)
			inStore = false
			get_parent().remove_child(self)
			g.mb._addMemory(self)
			_memoryEffectAdded()	

func _buyEffect() -> void:
	pass
	
func _sellMemory() -> void:
	pass
	
func _sellEffect() -> void:
	pass

func _setName(s : String) -> void:
	memName = s
	_setDat()
	$Sprite2D.texture = load(str("res://Memories/images/",memName,".jpg"))
	_setInfo()
	_setType()
	price = Prices[s]
	
func _setInfo() -> void:
	memInfo = ""
	match memName:
		"HelpingHand":
			memInfo = "+10 hand power"
		"Solitude":
			memInfo = "x4 multiplier if you have no accompanying soul"
		"SlotMachine":
			memInfo = str("[b] Slot Machine [/b]\n [color=#0000FF] +", phandP, " hand power[/color]\n Every [color=#FF0000] played 7[/color] has [color=#FFFF00] 1 in 2 chance [/color] to increase it by 3.")
		"Humility":
			memInfo = "Each card with value of less than 5 give 2x their value in soul power"
		"Sacrifice":
			memInfo = "Bet soul shards give thrice as much soulpower"
		"Sisu":
			memInfo = "Gains 1 soul power for each bet soul shard lost"
		"Heartbreak":
			memInfo = "gains +0.2 multiplier when a heart card is destroyed"
		"Rugpull":
			memInfo = "Gains + 1-25 handpower after each won hand. Handpower bonus in 250 chance to destroy itself at the end of round"
		"Credulity":
			memInfo = "All likelihoods are doubled"
		"Skepticism":
			memInfo = "All likelihoods are halved"
		"MotherOfLearning":
			memInfo = "The last drawn card is retriggered thrice"
		"Two-faced":
			memInfo = "face cards double the multiplier. 1 in 10 chance to halve it instead"
		"HeartyPorridge":
			memInfo = "The last drawn card changes its suit to hearts. if it already has that suit, it gives +15 handpower instead"
		"DrawingOfHeart":
			memInfo = ""
		"DrawingofDiamond":
			memInfo = ""
		"DrawingOfClub":
			memInfo = ""
		"DrawingofSpade":
			memInfo = ""
		"DrawingofS":
			memInfo = ""
		"ShoulderDevil":
			memInfo = "hitting when your total card value is over 15 gives +2 soul power"
		"ShoulderAngel":
			memInfo = "not hitting when your total card value is over 15 gives +2 soul power"
		"Crusader":
			memInfo = "played holy cards are turned into unholy cards of 1 level higher"
		"ColorTelevision":
			memInfo = "+0.1 multiplier for every suit in hand"
		"Ora":
			memInfo = "convert 20% of your soul power to hand power. Convert it back after all effects have resolved"
		"Labora":
			memInfo = "Convert 20% of your hand power to soul power. Convert it back after all effects have resolved"
		"Purification":
			memInfo = "All played cards lose their cursed enchantments. this memory gains x0.1 multiplication for each enchantment removed"
		"Canonization":
			memInfo = "All played face cards have 1 in 4 card to turn holy"
		"Outdoors":
			memInfo = "This memory gains + 0.5 soulpower for each played card under value of 7 and lose 1 soulpower for each played face card"
		"Temperance":
			memInfo = "If total worth is between 10 and 15, do x"
		"":
			memInfo = "Gain a soul shard for every cursed card in hand"
		"x":
			memInfo = "Increase bust limit by 3"
			
		

func _setType() -> void:
	match memName:
		"SlotMachine":
			triggerType = "hybrid"
		"Sacrifice":
			triggerType = "normal"
		"Humility":
			triggerType = "card"
		"Sacrifice":
			triggerType = "normal"
		"HelpingHand":
			triggerType = "normal"
		"Two-faced":
			triggerType = "card"
			
func _setDat() -> void:
	match memName:
		"SlotMachine":
			phandP = 0
		"HelpingHand":
			phandP = 0
		"Bench":
			Dat1 = 0
			Dat2 = 1
			phandP = 0
	upModText()

func _ready() -> void:
	if get_parent() is memory_box:
		g = get_parent().get_parent()
	else:
		g = get_parent().get_parent().get_parent()

func _getType() -> String:
	return triggerType
	
func _setPosition(i: int) -> void:
	memPos = i
	
func _getPosition() -> int:
	return memPos

func _memoryEffectAdded() -> void:
	match memName:
		"Credulity" : g.LikeliHoodModifier *= 2
		"Skepticism": g.LikeliHoodModifier /= 2
		"x": g.playerBust+=3
		
func _memoryEffectRemoved() -> void:
	match memName:
		"Credulity" : g.LikeliHoodModifier /= 2
		"Skepticism": g.LikeliHoodModifier *= 2
		"x": g.playerBust-=3

func _memoryTriggerCard(c : card, likelihoodmultiplier = 1) -> bool:
	match memName:
		"SlotMachine":
			if c.rank == Enums.seven:
				if randi_range(1,100) < 50*likelihoodmultiplier:
					print("jackpot!")
					return true
				else:
					print("no luck!")
					return false
		"Humility":
			return c.rank == Enums.zero || c.rank == Enums.one || c.rank == Enums.two || c.rank == Enums.three || c.rank == Enums.four
		"Two-faced":
			if c._isFaceCard():
					return true
		"Outdoors":
			if c._isFaceCard() || c._worth() < 7:
				return true
		"Bench":
			return true
		"Crazy8":
			return c._worth() == 8
		"Clover":
			return c._worth() == 4
	return false

func _memoryTrigger(likelihoodmultiplier = 1) -> bool:
	match memName:
		"SlotMachine":
			return true
		"Sacrifice":
			return true
		"HelpingHand":
			return true
		"Outdoors":
			return true
	return false

func _memoryTriggerRoundEnd(likelihoodmultiplier = 1) -> bool:
	match memName:
		"Rugpull":
			if randi_range(1,1000) <  4*phandP*likelihoodmultiplier:
				g._destroyMemory(self)
			phandP += randi_range(0,25)
	return false

func _memoryEffectCard(c : card = null, likelihoodmultiplier = 1) -> void:
	match memName:
		"SlotMachine":
			phandP +=3
			upModText()
		"Humility":
			g._increaseSoulPower(c._worth()*2)
		"Two-faced":
			if randi_range(1,1000) < 100*likelihoodmultiplier:
				g._multiplyMultiplier(0.5)
			else:
				g._multiplyMultiplier(2.0)
		"Outdoors":
			if c._isFaceCard():
				psoulP -= 1
			if c._worth() < 7:
				psoulP += 0.5
		"Bench":
			Dat1+=1
			if Dat1>=Dat2:
				phandP+=1
				Dat1-=Dat2
				Dat2+=2
		"Crazy8":
			c.changeSuit("a")
		"Clover":
			g._addLikelihood(0.5)

func _memoryEffect(likelihoodmultiplier = 1) -> void:
	match memName:
		"SlotMachine":
			g._increaseHandPower(phandP)
		"Sacrifice":
			g._increaseSoulPower(Global.bet * 2)
		"HelpingHand":
			g._increaseHandPower(phandP)
		"Outdoors":
			g._increaseSoulPower(psoulP)
		"Bench":
			g._increaseHandPower(phandP)
	
func _memoryEffectRoundEnd(likelihoodmultiplier = 1) -> void:
	pass
	
func _memoryReset() -> void:
	pass

func _createInfoBox() -> void:
	if box :
		if !box.getMovedMemory():
			_setInfo()
			$InfoBox/InfoText.text = memInfo
			$InfoBox.visible = true
	else:
		_setInfo()
		$InfoBox/InfoText.text = memInfo
		$InfoBox.visible = true
		
	
func _removeInfoBox() -> void:
	$InfoBox.visible = false

func _removeModText() -> void:
	$modifierText.visible = false
	
func _addModText() -> void:
	$modifierText.visible = true

func _hideBuyButton() -> void:
	$BuyButton.hide()

func _SelectMemory() -> void:
	if get_parent() is store:
		get_parent()._deSelectMems()
		$BuyButton.show()
