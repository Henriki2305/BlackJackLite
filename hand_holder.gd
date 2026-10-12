class_name handHolder extends Node2D

var heldHand : hand
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Hand Requirement".visible = false
	$HandReward.visible = false
	
func _setVals(h : hand) -> void:
	heldHand = h
	var info = h._getStrings()
	var reqs = info[0]
	var rews = info[1]
	var requirement = ""
	var bonus = ""
	for req : String in reqs:
		requirement = requirement + req + "\n"
	for rew : String in rews:
		bonus = bonus + rew + "\n"
	$Handname.text = str("[color=#0000FF]",h.stats.displayName,"[/color]")
	$"Hand Requirement".text = str("[color=#00FF00]",requirement,"[/color]")
	$HandReward.text = str("[color=#FF0000]",bonus,"[/color]")

func _mouse_enter() -> void:
	$"Hand Requirement".visible = true
	$HandReward.visible = true

func _mouse_exit() -> void:
	$"Hand Requirement".visible = false
	$HandReward.visible = false

func ie(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_takeHand()

func _takeHand() -> void:
	EventBus.handTaken.emit(heldHand)
	queue_free()
