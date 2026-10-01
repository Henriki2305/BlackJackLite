extends Node2D
class_name optionDoor

var doors : Array[door]
signal leave

func _setOptions() -> void:
	doors = []
	var text = SceneReferences._getOption()
	$Door1.optionName = text
	$Door1/OptionName.text = text
	$Door1/Description.text = SceneReferences._getDescription(text)	
	EventBus.optionShown.emit(text)
	text = SceneReferences._getOption()
	$Door2.optionName = text
	$Door2/OptionName.text = text
	$Door2/Description.text = SceneReferences._getDescription(text)	
	EventBus.optionShown.emit(text)
	text = SceneReferences._getOption()
	$Door3.optionName = text
	$Door3/OptionName.text = text
	$Door3/Description.text = SceneReferences._getDescription(text)	
	EventBus.optionShown.emit(text)
	doors.append($Door1)
	doors.append($Door2)
	doors.append($Door3)

func _emptyDoors() -> void:
	for d in doors:
		EventBus.optionRemoved.emit(d.optionName)

func _pickDoor1() -> void:
	var text = $Door1.optionName
	doors.remove_at(0)
	var b : Button = Button.new()
	b.name = text + "Button"
	EventBus.optionTaken.emit(b)
	_leave()
	
func _pickDoor2() -> void:
	var text = $Door2.optionName
	doors.remove_at(1)
	var b : Button = Button.new()
	b.name = text + "Button"
	EventBus.optionTaken.emit(b)
	_leave()
	
func _pickDoor3() -> void:
	var text = $Door3.optionName
	doors.remove_at(2)
	var b : Button = Button.new()
	b.name = text + "Button"
	EventBus.optionTaken.emit(b)
	_leave()

func _leave() -> void:
	hide()
	_emptyDoors()
	emit_signal("leave")
