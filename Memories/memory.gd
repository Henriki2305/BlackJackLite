
class_name memory extends Node2D

var triggerType : String #card, normal, hybrid, none

var memPos : int = 0
var memInfo : String = ""
var memName : String = ""
var Dat1
var Dat2
var Dat3
var g: Game
var box: memory_box

func _setBox(b:memory_box) -> void:
	box = b

func _setName(s : String) -> void:
	memName = s
	_setDat()
	$Sprite2D.texture = load(str("res://Memories/images/",memName,".jpg"))
	_setInfo()
	_setType()
	
func _setInfo() -> void:
	memInfo = ""
	match memName:
		"SlotMachine":
			memInfo = str("[b] Slot Machine [/b]\n [color=#0000FF] +", Dat1, " hand power[/color]\n Every [color=#FF0000] played 7[/color] has [color=#FFFF00] 1 in 2 chance [/color] to increase it by 3.")
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
		"HelpingHand":
			memInfo = "+10 hand power"
		"ShoulderDevil":
			memInfo = "hitting when your total card value is over 15 gives +20 soul power"
		"ShoulderAngel":
			memInfo = "not hitting when your total card value is over 15 gives +20 soul power"
		"Crusader":
			memInfo = "played holy cards are turned into unholy cards of 1 level higher"
		"ColorTelevision":
			memInfo = "+0.1 multiplier for every suit in hand"

func _setType() -> void:
	match memName:
		"SlotMachine":
			triggerType = "hybrid"
		"Humility":
			triggerType = "card"
		"Sacrifice":
			triggerType = "normal"
		
			
func _setDat() -> void:
	match memName:
		"SlotMachine":
			Dat1 = 0

func _ready() -> void:
	$InfoBox.visible = false
	g = get_parent().get_parent()

func _getType() -> String:
	return triggerType
	
func _setPosition(i: int) -> void:
	memPos = i
	
func _getPosition() -> int:
	return memPos

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
	return false

func _memoryTrigger(likelihoodmultiplier = 1) -> bool:
	match memName:
		"SlotMachine":
			return true
		"Sacrifice":
			return true
	return false

func _memoryEffectCard(c : card = null, likelihoodmultiplier = 1) -> void:
	match memName:
		"SlotMachine":
			Dat1 +=3
		"Humility":
			g._increaseSoulPower(c._worth()*2)

func _memoryEffect(likelihoodmultiplier = 1) -> void:
	match memName:
		"SlotMachine":
			g._increaseHandPower(Dat1)
		"Sacrifice":
			g._increaseSoulPower(Global.bet * 2)
	

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
