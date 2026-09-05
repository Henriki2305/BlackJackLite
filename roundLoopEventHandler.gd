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
	EventBus.stand.connect(_playRound)

func _playRound() -> void:
	var cardMemories: Array = memorybox._getMemories().filter(func(m): return (m is perCardMemory || m is hybridMemory))
	var instaMemories: Array = memorybox._getMemories().filter(func(m): return (m is instantMemory || m is hybridMemory))
	var mainCards: Array[card] = main._getCards()
	var sideCards: Array[card] = main._getCards()
	if (!main._checkBust()):
		for c in mainCards:
			var tween = get_tree().create_tween()
			var cs = c.transform.get_scale()
			tween.tween_property(c,"rotation_degrees", 15,0.02)
			tween.tween_property(c,"rotation_degrees", -15,0.04)
			tween.tween_property(c,"rotation_degrees", 0,0.02)
			EventBus.addHandPower.emit(c._worth())
			await get_tree().create_timer(0.35).timeout
			for m in cardMemories:
				if m._checkCardTrigger(c,1):
					m._perCardTrigger()
					var mTween = get_tree().create_tween()
					var cTween = get_tree().create_tween()
					mTween.tween_property(m,"rotation_degrees", 15,0.02)
					mTween.tween_property(m,"rotation_degrees", -15,0.04)
					mTween.tween_property(m,"rotation_degrees", 0,0.02)
					cTween.tween_property(c,"scale",cs*1.2,0.02)
					cTween.tween_property(c,"scale",cs,0.03)
					await get_tree().create_timer(0.35).timeout
			await get_tree().create_timer(0.35).timeout
		for c in sideCards:
			for m in cardMemories:
				if m._checkCardTrigger(c,1):
					m._perCardTrigger()
	for m in instaMemories:
		if m._CheckTrigger():
			m._triggerEffect()
			var mTween = get_tree().create_tween()
			var ms = m.transform.get_scale()
			mTween.tween_property(m,"scale",ms*1.2,0.02)
			mTween.tween_property(m,"scale",ms,0.03)
			await get_tree().create_timer(0.35).timeout
	EventBus.handPlayed.emit()

func _updatePlayState() -> void:
	var hands : Array[hand] = hBox._getHands()
	for h in hands:
		h._updateHand(main._getCards())
