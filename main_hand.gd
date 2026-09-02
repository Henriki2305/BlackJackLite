extends Node2D
class_name mainHand

# Called when the node enters the scene tree for the first time.

func sum(accum, number):
	return accum + number

func _getCards() -> Array[card]:
	return []

func _addCardToHand(c : card) -> void:
	c.reparent(self)
	print(c._getName())
	EventBus.bustValueChanged.emit(_calculateBustAmount())
	c.show()
	

func _checkBust() -> bool:
	return _calculateBustAmount() > 21

func _test() -> void:
	print("AAA")

func _calculateBustAmount() -> int:
	var cards : Array[card]
	cards.assign(find_children("*","card",true, false))
	var cardValues : Array = cards.map(func(c): return c._getBustvalue())
	return cardValues.reduce(sum, 0)

func _ready() -> void:
	EventBus.cardDrawn.connect(_addCardToHand)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
