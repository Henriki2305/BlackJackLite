class_name memory_box extends Node2D

var Memories = []
var movedMemory : memory
var playPhase : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$memory._setBox(self)
	$memory2._setBox(self)
	Memories.append($memory)
	Memories.append($memory2)
	$MslotMachine._setBox(self)
	Memories.append($MslotMachine)
	for i in len(Memories):
		Memories[i]._setPosition(i)
		Memories[i].position = Vector2(0,i*120)
		Memories[i].scale = Vector2(0.1,0.1)

func sort_memory(a:memory, b:memory):
	return a._getPosition() < b._getPosition()

func _getMemories() -> Array:
	Memories.sort_custom(sort_memory)
	return Memories

func getMovedMemory() -> memory:
	return movedMemory

func _addMemory(m : memory) -> void:
	m._setBox(self)
	m._setPosition(len(Memories))
	Memories.append(m)
	m.position = Vector2(0,(len(Memories)-1)*120)
	add_child(m)

func _process(delta: float) -> void:
	if movedMemory:
		var mPos = get_global_mouse_position()
		movedMemory.global_position = lerp(movedMemory.global_position,mPos,10*delta )
		for i in len(Memories):
			if Memories[i] != movedMemory:
				var m : memory = Memories[i]
				if (m._getPosition() > movedMemory._getPosition() && m.position[1] < movedMemory.position[1] )|| (m._getPosition() < movedMemory._getPosition() && m.position[1] > movedMemory.position[1]):
					_swapMemPos(i,movedMemory._getPosition())
					var tween = get_tree().create_tween()
					tween.tween_property(m,"position", Vector2(0,m._getPosition()*120),0.1)
					
				

func _input(event):
	if playPhase:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var m = raycast_check_mem()
				if m is memory:
					movedMemory = m
					m._startMoving()
					movedMemory._hideInfo()
#					movedMemory._removeModText()
			else:
				if movedMemory:
					var tween = get_tree().create_tween()
					tween.tween_property(movedMemory,"position", Vector2(0,movedMemory._getPosition()*120),0.1)
					var m = movedMemory
					movedMemory = null
					m._createInfo()
					m._stopMoving()
#					m._createInfoBox()
#					m._addModText()

func raycast_check_mem():
	var sState = get_world_2d().direct_space_state
	var par = PhysicsPointQueryParameters2D.new()
	par.position = get_global_mouse_position()
	par.collide_with_areas = true
	par.collision_mask = 1
	var res = sState.intersect_point(par)
	if res.size() >0:
		if res[0].collider.get_parent().get_parent().get_parent() is memory:
			var m : memory = res[0].collider.get_parent().get_parent().get_parent()
			if !m.inStore:
				return m

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _swapMemPos(i: int, j: int) -> void:
	var tempMem = Memories[i]
	Memories[i]._setPosition(j)
	Memories[j]._setPosition(i)
	Memories[i] = Memories[j]
	Memories[j] = tempMem
