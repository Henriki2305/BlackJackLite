extends Node

var memories : Dictionary = {
	"helpingHand": preload("res://Memories/InstantMemories/helpingHandMemory/MhelpingHand.tscn"),
	"shoulderDevil": preload("res://Memories/InstantMemories/ShoulderDevilMemory/MShoulderDevil.tscn"),
	"slotMachine": preload("res://Memories/HybridMemories/SlotMachineMemory/MslotMachine.tscn"),
	"humility": preload("res://Memories/PerCardMemories/humilityMemory/Mhumility.tscn"),
	"despair": preload("res://Memories/InstantMemories/despairMemory/Mdespair.tscn"),
	"weddingRing": preload("res://Memories/PerCardMemories/weddingRingMemory/MweddingRing.tscn")
}

var availableMemories : Dictionary

var options : Array[String] = ["Stand","Hit","Discard","Surrender","DoubleDown","Split","Burn"]
var availableOptions : Array
var hands : Dictionary = {
	"BigNumber": preload("res://Hands/BigNumberHand/BigNumberHand.tscn"),
	"Example": preload("res://Hands/ExampleHand/ExampleHand.tscn"),
	"Sleeve": preload("res://Hands/sleeveHand/sleeveHand.tscn")
}

var availableHands : Dictionary

func _ready() -> void:
	availableMemories = memories.duplicate()
	availableOptions = options.duplicate()
	availableHands = hands.duplicate()
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

func _removeHand(h : hand) -> void:
	var n = h.handName
	availableHands.erase(n)
	
func _addHand(h : hand) -> void:
	var n = h.handName
	availableHands[n] = memories[n]

func _getMemory() -> memory:
	return (availableMemories[availableMemories.keys()[randi() % availableMemories.size()]]).instantiate()
	
func _getHand() -> hand:
	return (availableHands[availableHands.keys()[randi() % availableHands.size()]]).instantiate()

#var buttons : 
