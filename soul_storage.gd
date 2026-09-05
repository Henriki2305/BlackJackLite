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
	EventBus.roundWon.connect(_winSouls)

func _winSouls(a:BigNumber) -> void:
	var ratio = a.to_float()
	var amount = 3
	if ratio > 2:
		amount+=1
	if ratio > 10:
		amount+=1
	if ratio > 50:
		amount+=1
	if ratio > 1000:
		amount+=3
	EventBus.winSouls.emit(amount)
	
	
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
