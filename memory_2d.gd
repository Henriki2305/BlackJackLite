class_name memory2D extends Node2D


@export 
var box:memory_box
var memPos : int = 0
var mem : memory = get_parent()

func _setBox(b:memory_box) -> void:
	box = b

func _upModText(tex: String) -> void:
	$modifierText.text = tex

func _buyMemory() -> void:
#	if SoulStorage._getSouls() >= price:
		$BuyButton.hide()
#		g.mb._addMemory(self)
		mem._buyMemory()


func _setName(s : String) -> void:
	$Sprite2D.texture = load(str("res://Memories/images/",s,".jpg"))

func _ready() -> void:
	pass

	
func _setPosition(i: int) -> void:
	memPos = i
	
func _getPosition() -> int:
	return memPos

func _createInfoBox(text : String) -> void:
	if box :
		if !box.getMovedMemory():
			$InfoBox/InfoText.text = text
			$InfoBox.visible = true
	else:
		$InfoBox/InfoText.text = text
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
