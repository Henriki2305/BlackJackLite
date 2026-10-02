extends Node

var memories : Dictionary = {
	"helpingHand": preload("res://Memories/InstantMemories/helpingHandMemory/MhelpingHand.tscn"),
	"shoulderDevil": preload("res://Memories/InstantMemories/ShoulderDevilMemory/MShoulderDevil.tscn"),
	"slotMachine": preload("res://Memories/HybridMemories/SlotMachineMemory/MslotMachine.tscn"),
	"humility": preload("res://Memories/PerCardMemories/humilityMemory/Mhumility.tscn"),
	"despair": preload("res://Memories/InstantMemories/despairMemory/Mdespair.tscn"),
	"weddingRing": preload("res://Memories/PerCardMemories/weddingRingMemory/MweddingRing.tscn"),
	"recursion": preload("res://Memories/TriggerMemories/Mrecursion.tscn"),
	"love": preload("res://Memories/PerCardMemories/loveMemory/Mlove.tscn")
}

var availableMemories : Dictionary

var options : Array[String] = ["Stand","Hit","Discard","Surrender","DoubleDown","Split","Burn","Aid", "Shuffle"]
var availableOptions : Array
var optionDescriptions : Dictionary = {
	"Stand" : "play the current hand",
	"Hit" : "draw a card to the main hand",
	"Discard" : "send the rightmost card in the main hand to the discard pile and lose 1 soul shard",
	"Surrender" : "lose the current round but keep half the bet soul shards",
	"DoubleDown" : "double the bet amount, draw a card and stand. +2 to round reward",
	"Split" : "send right half of the main hand to the side hand. usable once per round and only if the player has not busted",
	"Burn" : "destroy the last drawn card",
	"Aid" : "draw 3 cards to the side hand. Bust if their bust value is higher than the main hand's",
	"Shuffle" : "shuffle all cards in main hand into the deck once per round"
}
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
	EventBus.handGivenToDemon.connect(_removeHand)
	EventBus.handTakenFromDemon.connect(_addHand)
	EventBus.optionShown.connect(_removeOption)
	EventBus.optionRemoved.connect(_addOption)
	
	
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
	
func _getOption() -> String:
	return (availableOptions.pick_random())

func _removeOption(s : String) -> void:
	availableOptions.erase(s)

func _addOption(s : String) -> void:
	availableOptions.append(s)
	
func _getDescription(s : String) -> String:
	return optionDescriptions[s]
