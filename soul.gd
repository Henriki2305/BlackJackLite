extends Node2D

class_name soul
# Called when the node enters the scene tree for the first time.

var soulName : String = "a"
var soulDesc : Dictionary = {
	"test1" : "test",
	"test2" : "test",
	"test3" : "test",
	"a" : "b"
}
var soulColors : Dictionary = {
	"test1" : [Vector3(1.0,0.0,0.0),Vector3(0.8,0.1,0.1)],
	"test2" : [Vector3(0.0,0.0,1.0),Vector3(0.0,0.75,0.0)],
	"test3" : [Vector3(0.5,0.0,0.5),Vector3(0.3,0.05,0.2)]
}
var inInventory : bool
var g : Game
var value : int

func _getValue() -> int:
	return value
	
func _setValue(v : int) -> void:
	value = v

func _ready() -> void:
	$SacrificeButton.hide()
	inInventory = false

func _setName(nam : String) -> void:
	soulName = nam
	$SoulSprite.material.set_shader_parameter("col1",soulColors[nam][0])
	$SoulSprite.material.set_shader_parameter("col2",soulColors[nam][1])

func _getSoulRule() -> String:
	return soulName

func _hideButton() -> void:
	$SacrificeButton.hide()
	
func _showButton() -> void:
	if inInventory:
		$SacrificeButton.show()

func _hideDesc() -> void:
	$SoulDesc.hide()
	
func _showDesc() -> void:
	$SoulDesc.text = soulName + "//" + soulDesc[soulName]
	$SoulDesc.show()

func _buySoul() -> String:
	inInventory = true
	return soulName
	
func _sacrificeSoul() -> void:
	g.soulRules[soulName]=false
	queue_free()
	
