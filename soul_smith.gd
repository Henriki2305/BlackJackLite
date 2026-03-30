class_name Smith extends Node2D

var currentSoul : soul
var price : int = 5
var g : Game
var possibleSouls : Array[String]
var soulScene = preload("res://Scenes/soul.tscn")
signal leave

func _NewSoul() -> void:
	if g.souls > price:
		if currentSoul != null:
			currentSoul.queue_free()
		g._addToSouls(-price)
		currentSoul = soulScene.instantiate()
		currentSoul._setName(possibleSouls.pick_random())
		add_child(currentSoul)
		currentSoul.global_position=Vector2(1000,500)
		price += 5
		$BuyButton.show()

func _returnBack() -> void:
	hide()
	emit_signal("leave")

func _BuySoul() -> void:
	if len(g.currentSouls) < g.MaxSouls:
		remove_child(currentSoul)
		g._recruitSoul(currentSoul)
		$BuyButton.hide()
		currentSoul = null

# Called when the node enters the scene tree for the first time.

func _setPossibleSouls(souls : Array[String]) -> void:
	possibleSouls = souls

func _ready() -> void:
	$BuyButton.hide()
	g = get_parent().get_parent()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
