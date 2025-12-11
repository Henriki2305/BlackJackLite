class_name store extends Node2D

var cardScene = preload("res://Scenes/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

var g: Game

var cards : Array[card] = []

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

func _resetPos(c:card) -> void:
	c.position = Vector2(0,0)

func _emptyStore() -> void:
	for c in cards:
		if c._inStore():
			c.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
