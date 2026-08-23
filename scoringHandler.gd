extends Node

var SoulPower : BigNumber = BigNumber.new()
var HandPower : BigNumber = BigNumber.new()
var Multiplier : BigNumber = BigNumber.new()
var totalPower : BigNumber = BigNumber.new()
var opponentScore : BigNumber = BigNumber.new()
var notationLimit : BigNumber = BigNumber.new()
var Emode : bool = true;
signal hand
signal handx
signal soul
signal soulx
signal multi
signal multix
signal multip

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	notationLimit.mantissa=1
	notationLimit.exponent=9
	hand.connect(_increaseHandPower)
	handx.connect(_multiplyHandPower)
	soul.connect(_increaseSoulPower)
	soulx.connect(_multiplySoulPower)
	multi.connect(_increasemultiplier)
	multix.connect(_multiplyMultiplier)
	multip.connect(_multiplyMultiplierbyPercent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _increaseHandPower(amount) -> void:
	HandPower = HandPower.plus(amount)
	_updatePower()
	
func _increaseSoulPower(amount) -> void:
	SoulPower = SoulPower.plus(amount)
	_updatePower()
	
func _increasemultiplier(amount) -> void:
	Multiplier = Multiplier.plus(amount)
	_updatePower()
	
func _multiplyHandPower(amount) -> void:
	HandPower = HandPower.multiply(amount)
	_updatePower()
	
func _multiplySoulPower(amount) -> void:
	SoulPower = SoulPower.multiply(amount)
	_updatePower()
	
func _multiplyMultiplier(amount) -> void:
	Multiplier = Multiplier.multiply(amount)
	_updatePower()
	
func _multiplyMultiplierbyPercent(amount) -> void:
	Multiplier = Multiplier.multiply(Multiplier.multiply(1+amount))


func _updatePower() -> void:
	pass
#	if HandPower.is_greater_than(notationLimit) && !Emode:
#		$HandPowerText.text = str("Handpower: ",HandPower.to_metric_name())
#	else:
#		$HandPowerText.text = str("Handpower: ",HandPower.to_scientific())
#	$SoulPowerText.text = str("Soulpower: ", SoulPowerNew._IntoText())
#	$MultiplierText.text = str("Multiplier: ",MultiplierNew._IntoText())
#	TotalPowerNew.Vals = TotalPowerNew._ValMult(SoulPowerNew.Vals,TotalPowerNew._ValMult(HandPowerNew.Vals,MultiplierNew.Vals))
#	TotalPowerNew._updateValue()
#	$TotalPowerText.text = str("Total power: ", TotalPowerNew._IntoText())
#	if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(3)):
#		$ColorRect.material.set_shader_parameter("width",0.0125)
#		$ColorRect.material.set_shader_parameter("spot",0.03)
#		ripple = true
