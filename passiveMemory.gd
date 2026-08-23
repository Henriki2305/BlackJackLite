@abstract
extends memory
class_name passiveMemory

func _hasPassiveEffect() -> bool:
	return true
	
@abstract
func _triggerPassiveEffect()

func _buyEffect() -> void:
	_triggerPassiveEffect()
