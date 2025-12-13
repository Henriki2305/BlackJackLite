class_name handHolder extends Node2D

var handName : String
var requirement : String
var bonus : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Hand Requirement".visible = false
	$HandReward.visible = false
	_setVals("heh","hah","höh")
	
func _setVals(a : String, b : String, c : String) -> void:
	handName = a
	requirement = b
	bonus = c
	$Handname.text = str("[color=#0000FF]",handName,"[/color]")
	$"Hand Requirement".text = str("[color=#00FF00]",requirement,"[/color]")
	$HandReward.text = str("[color=#FF0000]",bonus,"[/color]")

func _mouse_enter() -> void:
	$"Hand Requirement".visible = true
	$HandReward.visible = true

func _mouse_exit() -> void:
	$"Hand Requirement".visible = false
	$HandReward.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
