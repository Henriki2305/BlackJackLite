extends Node2D

var actions : Array[Button] = []

func _ready() -> void:
	for a in $Control.get_children().filter(func(b) : return b is Button) :
		actions.append(a)
		_connectButton(a)
	EventBus.betPlaced.connect(show)
	EventBus.endRound.connect(hide)
	EventBus.optionTaken.connect(_addButton)
	
func _addButton(b : Button) -> void:
	$Control.add_child(b)
	b.position = Vector2(300,0)
	print(b.name)
	b.show()
	b.text=b.name
	_connectButton(b)
	actions.append(b)

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
	if(Global.soulShardsAmount > 1):
		EventBus.spendSouls.emit(1)
		EventBus.discard.emit()
	print("discard")
	
func _surrender() -> void:
	EventBus.surrender.emit()
	print("surrender")
	
func _doubleDown() -> void:
	EventBus.doubleDown.emit()
	
func _split() -> void:
	EventBus.split.emit()
	
func _burn() -> void:
	EventBus.burnAction.emit()
