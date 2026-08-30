extends Node2D
class_name mainHand

# Called when the node enters the scene tree for the first time.

func sum(accum, number):
	return accum + number

func _getCards() -> Array[card]:
	return []

func _checkBust() -> bool:
	return _calculateBustAmount() > 21

func _calculateBustAmount() -> int:
	var cards : Array[card] = get_children().filter(func(c): return ( c is card ))
	var cardValues : Array[int] = cards.map(func(c): c._getBustValue())
	return cards.reduce(sum, 0)

func _ready() -> void:
	EventBus.requestBustLimit.connect(_sendBustAmount)

func _sendBustAmount(m : memory) -> void:
	m._bustLimitReceived(_calculateBustAmount())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
