extends instantMemory


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.hitCard.connect(_checkCondition)
	EventBus.endRound.connect(_deActivate)
	EventBus.bustValueChanged.connect(_updateLimit)	
	
func _updateLimit(b:int) -> void:
	memoryStats.var2 = b
	
	
func _checkCondition() -> void:
	if memoryStats.var2 > 15:
		_Activate()

func _triggerEffect() -> void:
	if (memoryStats.var1):
		EventBus.multiplySoulPower.emit(2.5)
	
func _Activate() -> void:
	memoryStats.var1 = true
	
func _deActivate() -> void:
	memoryStats.var1 = false
	memoryStats.var2 = 0
