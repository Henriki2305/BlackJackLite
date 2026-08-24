extends Node

@export
var memorybox : memory_box
@export
var main : mainHand
@export
var side : sideHand
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _playRound() -> void:
	var cardMemories: Array[perCardMemory] = memorybox._getMemories().filter(func(m): return (m is perCardMemory))
	var instaMemories: Array[instantMemory] = memorybox._getMemories().filter(func(m): return (m is instantMemory))
	var mainCards: Array[card] = main._getCards()
	var sideCards: Array[card] = main._getCards()
	pass
