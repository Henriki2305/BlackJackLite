@abstract
extends perCardMemory
class_name hybridMemory

func _hasInstantEffect() -> bool:
	return true
	
@abstract
func _triggerEffect() -> void
