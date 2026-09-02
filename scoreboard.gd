extends Node2D

var notationLimit : BigNumber

func _ready() -> void:
	notationLimit.mantissa = 1.0
	notationLimit.exponent = 10
	EventBus.soulPowerChanged.connect(_updateSoulPower)
	EventBus.handPowerChanged.connect(_updateHandPower)
	EventBus.multiplierChanged.connect(_updateMultiplier)
	EventBus.totalChanged.connect(_updateTotalPower)
	EventBus.scoreLimitChanged.connect(_updateOpponentScore)

func _updateSoulPower(n : BigNumber) -> void:
	$SoulPower.text=(_IntoText(n))
	
	
func _updateHandPower(n : BigNumber) -> void:
	$Handpower.text=(_IntoText(n))
	
func _updateMultiplier(n : BigNumber) -> void:
	$Multiplier.text=(_IntoText(n))
	
func _updateTotalPower(n : BigNumber) -> void:
	$Total.text=(_IntoText(n))
	
func _updateOpponentScore(n : BigNumber) -> void:
	$"Points required".text=(_IntoText(n))

func _IntoText(n : BigNumber) -> String:
	if n.is_less_than(notationLimit):
		return str(n.to_float())
	return n.to_plain_scientific()
