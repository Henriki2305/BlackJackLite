class_name Smith extends Node2D

var currentSoul : soul
var price : int = 5
var g : Game
var possibleSouls : Array[soul]
var soulScene = preload("res://Scenes/soul.tscn")

func _NewSoul() -> void:
	if g.souls > price:
		if currentSoul != null:
			currentSoul.queue_free()
		currentSoul = soulScene.instantiate()
		add_child(currentSoul)
		price += 5

func _returnBack() -> void:
	pass

func _BuySoul() -> void:
	if len(g.currentSouls) < g.MaxSouls:
		remove_child(currentSoul)
		g._recruitSoul(currentSoul)

# Called when the node enters the scene tree for the first time.

func _setPossibleSouls(souls : Array[soul]) -> void:
	possibleSouls = souls

func _ready() -> void:
	$SmithButton.pressed.connect(_NewSoul)
	$ReturnButton.pressed.connect(_returnBack)
	$BuyButton.pressed.connect(_BuySoul)
	g = get_parent().get_parent()
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
