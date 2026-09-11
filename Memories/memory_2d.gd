class_name memory2D extends Node2D

@export 
var box:memory_box
@export
var memPos : int = 0
signal HovSignal

func _setBox(b:memory_box) -> void:
	box = b

func _upModText(tex: String) -> void:
	$modifierText.text = tex

func _buyMemory() -> void:
	EventBus.buyMemory.emit(get_parent())


func _setImage(image : Texture2D) -> void:
	$Sprite2D.texture = image

func _ready() -> void:
	pass
	
func _setHover(hov) -> void:
	hov.hovered.connect(_onHovered)
	hov.unhovered.connect(_removeInfoBox)

func _onHovered() -> void:
	HovSignal.emit()
	
func _setPosition(i: int) -> void:
	memPos = i
	
func _getPosition() -> int:
	return memPos

func _setMoved(m : bool) -> void:
	$Sprite2D/Area2D._setMoved(m)

func _createInfoBox(text : String) -> void:
	if box :
		if !box.getMovedMemory():
			$InfoBox/InfoText.text = text
			$InfoBox.visible = true
	else:
		$InfoBox/InfoText.text = text
		$InfoBox.visible = true
		
func _giveArea2D() -> Area2D :
	return $Sprite2D/Area2D
	
func _removeInfoBox() -> void:
	$InfoBox.visible = false

func _removeModText() -> void:
	$modifierText.visible = false
	
func _addModText() -> void:
	$modifierText.visible = true

func _hideBuyButton() -> void:
	$BuyButton.hide()

func _SelectMemory() -> void:
	var mem : memory = get_parent()
	if mem.inStore:
		mem.get_parent()._deSelectMems()
		$BuyButton.show()
