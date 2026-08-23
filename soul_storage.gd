extends Node2D

var souls : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setAmount(a : int) -> void:
	souls = a
	
func _loseSouls(a : int) -> void:
	souls-=a
	
func _spendSouls(a : int) -> void:
	souls-=a
	
func _consumeSouls(a : int) -> void:
	souls-=a
	
func _winSouls(a : int) -> void:
	souls+=a

func _createSouls(a : int) -> void:
	souls+=a

func _getSouls() -> int:
	return souls
