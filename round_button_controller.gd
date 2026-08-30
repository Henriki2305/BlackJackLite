extends Node2D

var actions : Array[Button] = []

func _ready() -> void:
	for a in get_children().filter(func(b) : b is Button) :
		actions.append(a)
		_connectButton(a)

func _connectButton(b : Button) -> void:
	if actions.size() < 4:
		match b.name :
			"HitButton": b.pressed.connect(_hit)
			"StandButton": b.pressed.connect(_stand)
			"DiscardButton": b.pressed.connect(_discard)
			"SurrenderButton": b.pressed.connect(_surrender)
			"DoubleDownButton": b.pressed.connect(_doubleDown)
			"SplitButton": b.pressed.connect(_split)
			"BurnButton": b.pressed.connect(_burn)
	

func _hit() -> void:
	EventBus.hitCard.emit()
	
func _stand() -> void:
	EventBus.stand.emit()

func _discard() -> void:
	EventBus.discard.emit()
	
func _surrender() -> void:
	EventBus.surrender.emit()
	
func _doubleDown() -> void:
	EventBus.doubleDown.emit()
	
func _split() -> void:
	EventBus.split.emit()
	
func _burn() -> void:
	EventBus.burnAction.emit()
