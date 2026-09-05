extends Node

var memories : Dictionary = {
	"helpingHand": preload("res://Memories/InstantMemories/helpingHandMemory/MhelpingHand.tscn")
}

var hands : Dictionary = {
	
}

func _getMemory() -> memory:
	return (memories[memories.keys()[randi() % memories.size()]]).instantiate()

#var buttons : 
