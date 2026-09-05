extends Node2D

# Called when the node enters the scene tree for the first time.

func _getCards() -> Array[card]:
	var c : Array[card]
	c.assign(find_children("*","card",true, false))
	return c

func _discardCard(c : card) -> void:
	c.reparent(self)
	c.hide()

func _sendCardsToDeck() -> void:
	for c in _getCards():
		EventBus.cardReturned.emit(c)
	
func _ready() -> void:
	EventBus.cardDiscarded.connect(_discardCard)
	EventBus.roundWon.connect(_sendCardsToDeck)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
