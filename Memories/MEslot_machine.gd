class_name slot_machineMemory extends memory

var mod = 0

func _ready() -> void:
	super._setType("hybrid")

func _GetType() -> String:
	return super._getType()

func _memoryTriggerCard(c : card, likelihoodmultiplier = 1) -> bool:
	if c.rank == Enums.seven:
		if randi_range(1,100) < 50*likelihoodmultiplier:
			print("jackpot!")
			return true
		else:
			print("no luck!")
	return false

func _memoryTrigger(likelihoodmultiplier = 1) -> bool:
	return true

func _memoryEffectCard(c : card, likelihoodMultiplier = 1) -> void:
	mod += 3
func _memoryEffect(likelihoodMultiplier = 1) -> void:	
	get_parent()._increaseHandPower(mod)
