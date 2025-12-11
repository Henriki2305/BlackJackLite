
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

func _setType() -> void:
	match memName:
		"SlotMachine":
			triggerType = "hybrid"
			
func _setDat() -> void:
	match memName:
		"SlotMachine":
			Dat1 = 0

func _ready() -> void:
	$Sprite2D.texture = load("res://Memories/images/SlotMachine.jpg")
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
	return false

func _memoryTrigger(likelihoodmultiplier = 1) -> bool:
	match memName:
		"SlotMachine":
			return true
	return false

func _memoryEffectCard(c : card = null, likelihoodmultiplier = 1) -> void:
	match memName:
		"SlotMachine":
			Dat1 +=3

func _memoryEffect(likelihoodmultiplier = 1) -> void:
	match memName:
		"SlotMachine":
			g._increaseHandPower(Dat1)
	

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
