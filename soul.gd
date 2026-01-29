extends Node2D

class_name soul
# Called when the node enters the scene tree for the first time.

var soulName : String
var inInventory : bool
var g : Game

func _ready() -> void:
	$SacrificeButton.hide()
	inInventory = false

func _setName(name : String) -> void:
	soulName = name

func _getSoulRule() -> String:
	return soulName

func _hideButton() -> void:
	$SacrificeButton.hide()
	
func _showButton() -> void:
	$SacrificeButton.show()

func _buySoul() -> String:
	inInventory = true
	return soulName
	
func _sacrificeSoul() -> void:
	g.soulRules[soulName]=false
	queue_free()
	
