extends Node2D
class_name mainHand

# Called when the node enters the scene tree for the first time.

func sum(accum, number):
	return accum + number

func _getCards() -> Array[card]:
	return []

func _checkBust() -> bool:
	var cards : Array[card] = get_children().filter(func(c): return ( c is card ))
	var cardValues : Array[int] = cards.map(func(c): c._getBustValue())
	return cards.reduce(sum, 0) > 21


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
