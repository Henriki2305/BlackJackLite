class_name memory_box extends Node2D

var Memories = []
var movedMemory : memory
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Vector2(0,0)
	$memory._setName("SlotMachine")
	$memory2._setName("SlotMachine")
	$memory._setBox(self)
	$memory2._setBox(self)
	Memories.append($memory)
	Memories.append($memory2)
	for i in len(Memories):
		Memories[i]._setPosition(i)
		Memories[i].global_position = Vector2(400,500+(i*120))

func _getMemories() -> Array:
	return Memories

func getMovedMemory() -> memory:
	return movedMemory

func _addMemory(m : memory) -> void:
	Memories.append(m)
	m.global_position = Vector2(400,500+((len(Memories)-1)*120))
	add_child(m)

func _process(delta: float) -> void:
	if movedMemory:
		var mPos = get_global_mouse_position()
		movedMemory.position = mPos
		for i in len(Memories):
			if Memories[i] != movedMemory:
				var m : memory = Memories[i]
				if (m._getPosition() > movedMemory._getPosition() && m.global_position[1] < movedMemory.global_position[1] )|| (m._getPosition() < movedMemory._getPosition() && m.global_position[1] > movedMemory.global_position[1]):
					_swapMemPos(i,movedMemory._getPosition())
					var tween = get_tree().create_tween()
					tween.tween_property(m,"global_position", Vector2(600,500+(m._getPosition()*120)),0.1)
					
				

func _input(event):
	if get_parent().playPhase:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var m = raycast_check_mem()
				if m is memory:
					movedMemory = m
					movedMemory._removeInfoBox()
					movedMemory._removeModText()
			else:
				if movedMemory:
					var tween = get_tree().create_tween()
					tween.tween_property(movedMemory,"global_position", Vector2(600,500+(movedMemory._getPosition()*120)),0.1)
					var m = movedMemory
					movedMemory = null
					m._createInfoBox()
					m._addModText()

func raycast_check_mem():
	var sState = get_world_2d().direct_space_state
	var par = PhysicsPointQueryParameters2D.new()
	par.position = get_global_mouse_position()
	par.collide_with_areas = true
	par.collision_mask = 1
	var res = sState.intersect_point(par)
	if res.size() >0:
		if res[0].collider.get_parent().get_parent() is memory:
			var m : memory = res[0].collider.get_parent().get_parent()
			if !m.inStore:
				return m

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _swapMemPos(i: int, j: int) -> void:
	var tempMem = Memories[i]
	Memories[i]._setPosition(j)
	Memories[j]._setPosition(i)
	Memories[i] = Memories[j]
	Memories[j] = tempMem
