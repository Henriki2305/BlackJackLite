@abstract
extends memory
class_name instantMemory

func _hasInstantEffect() -> bool:
	return true
	
@abstract
func _triggerEffect() -> void
