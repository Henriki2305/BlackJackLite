class_name store extends Node2D

var cardScene = preload("res://Scenes/card.tscn")
var memScene = preload("res://Memories/memory.tscn")
var BoosterScene = preload("res://Scenes/booster_pack.tscn")
var memos : Array[memory]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

var g: Game

var cards : Array[card] = []

func _hasMem(n: String, a: Array) -> bool:
	for m in a:
		if m.memName == n:
			return true
	return false

func _createStore() -> void:
	global_position = Vector2(0,0)
	g = get_parent().get_parent()
	var mems = g._getMemsInGame()
	var usedMems = g.mb.Memories
	var usableMems = mems.filter(func(a): return !_hasMem(a,usedMems))
	for i in range(min(3,len(usableMems))):
		var n: String = usableMems.pick_random()
		var m : memory = memScene.instantiate()
		m._setName(n)
		m.scale = Vector2(0.2,0.2)
		add_child(m)
		m.inStore = true
		m.global_position = Vector2(-625+i*200,-40)
		memos.append(m)
		print(n)
	for i in range(2):
		var bp : boosterPack = BoosterScene.instantiate()
		add_child(bp)
		bp.global_position = Vector2(-625+i*200,160)

func _createCards() -> void:
	g = get_parent().get_parent()
	for i in range(2):
		for j in range(4):
			var card_instance = cardScene.instantiate()
			card_instance.setValues(g._getRandomCard())
			add_child(card_instance)
			card_instance.visible = true
			card_instance._unpacked()
			card_instance.scale = Vector2(0,0)
			card_instance.position = Vector2(200+j*300,i*500)
			var tween = get_tree().create_tween()
			var rotTween = get_tree().create_tween()
			rotTween.tween_property(card_instance,"rotation_degrees", 1080,0.75)
			tween.tween_property(card_instance,"scale", Vector2(1,1),0.65)
			cards.append(card_instance)

func _leaveStore() -> void:
	visible = false

func _resetPos(c:card) -> void:
	c.position = Vector2(0,0)

func _deSelectMems() -> void:
	for m in memos:
		m._hideBuyButton()

func _emptyStore() -> void:
	for c in cards:
		if c._inStore():
			c.queue_free()
