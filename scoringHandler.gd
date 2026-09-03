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
	EventBus.addHandPower.connect(_increaseHandPower)
	EventBus.multiplyHandPower.connect(_multiplyHandPower)
	EventBus.addSoulPower.connect(_increaseSoulPower)
	EventBus.multiplySoulPower.connect(_multiplySoulPower)
	EventBus.addMultiplier.connect(_increasemultiplier)
	EventBus.multiplyMultiplier.connect(_multiplyMultiplier)
	EventBus.multiplyMultiplierPercent.connect(_multiplyMultiplierbyPercent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _resetPower() -> void:
	HandPower.exponent = 0.0
	HandPower.mantissa = 0.0
	SoulPower.exponent = 0.0
	SoulPower.mantissa = 0.0
	Multiplier.exponent = 0.0
	Multiplier.mantissa = 1.0
	_updatePower()
	

func _increaseHandPower(amount) -> void:
	print(amount)
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
	totalPower = (HandPower.multiply(SoulPower)).multiply(Multiplier)
	EventBus.handPowerChanged.emit(HandPower)
	EventBus.soulPowerChanged.emit(SoulPower)
	EventBus.multiplierChanged.emit(Multiplier)
	EventBus.totalChanged.emit(totalPower)
#	if TotalPowerNew._GreaterThan(OpponentScoring._MultipliedByNum(3)):
#		$ColorRect.material.set_shader_parameter("width",0.0125)
#		$ColorRect.material.set_shader_parameter("spot",0.03)
#		ripple = true
