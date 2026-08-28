extends Node2D

var souls : int = 0
var counter : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.loseSouls.connect(_decreaseSouls)
	EventBus.spendSouls.connect(_decreaseSouls)
	EventBus.consumeSouls.connect(_decreaseSouls)
	EventBus.winSouls.connect(_increaseSouls)
	EventBus.createSouls.connect(_increaseSouls)
	while true:
		await get_tree().create_timer(1.75).timeout
		_increaseSouls(5)
	

func _process(delta: float) -> void:
	pass

func _setAmount(a : int) -> void:
	var tween = get_tree().create_tween()
	souls = a
	tween.tween_property($soulProgressBar,"value",(1-(1/(1+souls/25.0)))*100,1.5)
	
func _increaseSouls(a : int) -> void:
	var tween = get_tree().create_tween()
	souls+=a
	tween.tween_property($soulProgressBar,"value",(1-(1/(1+souls/25.0)))*100,1.5)
	
func _decreaseSouls(a : int) -> void:
	var tween = get_tree().create_tween()
	souls-=a
	tween.tween_property($soulProgressBar,"value",(1-(1/(1+souls/25.0)))*100,1.5)
		
func _getSouls() -> int:
	return souls
