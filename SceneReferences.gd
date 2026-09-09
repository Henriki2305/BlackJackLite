extends Node

var memories : Dictionary = {
	"helpingHand": preload("res://Memories/InstantMemories/helpingHandMemory/MhelpingHand.tscn"),
	"shoulderDevil": preload("res://Memories/InstantMemories/ShoulderDevilMemory/MShoulderDevil.tscn"),
	"slotMachine": preload("res://Memories/HybridMemories/SlotMachineMemory/MslotMachine.tscn"),
	"humility": preload("res://Memories/PerCardMemories/humilityMemory/Mhumility.tscn")
}

var availableMemories : Dictionary

var hands : Dictionary = {
	
}

func _ready() -> void:
	availableMemories = memories
	EventBus.memoryBought.connect(_removeMemory)
	EventBus.memorySoldUnique.connect(_addMemory)
	EventBus.memoryRolledToStore.connect(_removeMemory)
	EventBus.memoryRolledFromStore.connect(_addMemory)
	
func _removeMemory(m : memory) -> void:
	var n = m._getName()
	availableMemories.erase(n)

func _addMemory(m : memory) -> void:
	var n = m._getName()
	availableMemories[n] = memories[n]

func _getMemory() -> memory:
	return (availableMemories[availableMemories.keys()[randi() % availableMemories.size()]]).instantiate()

#var buttons : 
