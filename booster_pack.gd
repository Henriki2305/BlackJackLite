class_name boosterPack extends Node2D
var cardSets : Dictionary = {
	"FaceOfHearts" : [["nohcoa",250],["nohco2",250],["nohco3",250],["nohco4",250]]
}
var cardSetsRare : Dictionary = {
	"FaceOfHearts" : [["nohsha",100],["nohra2",300],["nohra3",300],["nohra4",300]]
}
var cardScene = preload("res://Scenes/card.tscn")
var sc = scale
var cSet : String
var opening : bool = false
var c = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cSet = "FaceOfHearts"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _center() -> void:
	var a = get_tree().create_tween()
	var b = get_tree().create_tween()
	var s = self.scale
	a.tween_property(self,"scale",s*1.5,0.5)
	a.tween_property(self,"global_position",Vector2(960,540),0.5)
	await get_tree().create_timer(2.25).timeout
	_openPackAnimation()	

func _openPackAnimation() -> void:
	var t = get_tree().create_tween()
	t.tween_property($CardBack,"global_position",Vector2(960,-500),1.5)
	await get_tree().create_timer(1.75).timeout
	$PackSprite.visible = false
	_createCard()

func _createCard() -> void:
	var s : Array = []
	var st : String = ""
	var r = randi_range(0,1000)
	if c == 6:
		queue_free()
	if c == 4:
		s = cardSetsRare[cSet]
	else:
		s = cardSets[cSet]
	for i in range(len(s)):
		if r <= s[i][1]:
			st = s[i][0]
		r -= s[i][1]
		if r < 0:
			break
	var ca = cardScene.instantiate()
	ca.setValues(st)
	add_child(ca)
	ca.visible = true
	ca._unpacked()
	ca.scale = Vector2(1.0,1.0)
	ca.global_position = Vector2(960,540)
	c+=1
			
			

func _mouse_enter() -> void:
	if !opening:
		var sTween = get_tree().create_tween()
		sTween.tween_property(self,"scale",sc*1.2,0.1)
	
func _mouse_exit() -> void:
	if !opening:
		var sTween = get_tree().create_tween()
		sTween.tween_property(self,"scale",sc,0.1)


func _mouse_click():
	opening = true
	var sTween = get_tree().create_tween()
	sTween.tween_property(self,"scale",sc,0.1)
	await get_tree().create_timer(0.11).timeout
	_center()
	
