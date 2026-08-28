extends Node

@export
var memorybox : memory_box
@export
var main : mainHand
@export
var side : sideHand
@export
var hBox : handbox
var bustLimit = 21
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.playRound.connect(_playRound)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _playRound() -> void:
	var cardMemories: Array[perCardMemory] = memorybox._getMemories().filter(func(m): return (m is perCardMemory || m is hybridMemory))
	var instaMemories: Array[instantMemory] = memorybox._getMemories().filter(func(m): return (m is instantMemory))
	var mainCards: Array[card] = main._getCards()
	var sideCards: Array[card] = main._getCards()
	
	if (!main._checkBust()):
		for c in mainCards:
#			ScoreSystem.hand.emit(c._worth())
			for m in cardMemories:
				if m._checkCardTrigger(c,1):
					m._perCardTrigger()
		for c in sideCards:
			for m in cardMemories:
				if m._checkCardTrigger(c,1):
					m._perCardTrigger()
	pass

func _updatePlayState() -> void:
	var hands : Array[hand] = hBox._getHands()
	for h in hands:
		h._updateHand(main._getCards())
