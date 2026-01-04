class_name boosterPack extends Node2D
var cardSets : Dictionary = {
	"FaceOfHearts" : [["nohcoa",250],["nohco2",250],["nohco3",250],["nohco4",250]]
}
var cardSetsRare : Dictionary = {
	"FaceOfHearts" : [["nohsha",100],["nohra2",300],["nohra3",300],["nohra4",300]]
}
var cardScene = preload("res://card.gd")
var sc = scale
var cSet : String
var opening : bool = false
var c = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _createCard() -> void:
	var s : Array = []
	var st : String = ""
	var r = randi_range(0,1000)
	if c == 7:
		s = cardSetsRare[cSet]
	else:
		s = cardSets[cSet]
	for i in range(len(s)):
		if r <= s[i][1]:
			st = s[i][0]
		r -= s[i][1]
		if r < 0:
			break
			
			
			

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
	
