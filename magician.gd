class_name magician extends Node2D

enum types {
	bokor, #Louisianan
	ẖrjḥꜣb, #kheri-hab, Egyptian
	shaman, #Finnish
	wizard, #Bri'ish or something
	fortuneteller, #Romani
	bruja, #South American
	kitsunemochi, #Japanese
	mime #French eww
}
var magicianType : int

func BaronSamedi() -> void:
	pass
	
func BravGede() -> void:
	pass
	
func Ra() -> void:
	pass

func Ukko() -> void:
	pass

func Tapio() -> void:
	pass
	
func Ahti() -> void:
	pass
	
func CardFromSleeve() -> void:
	pass

func ColoredScarf() -> void:
	pass



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _generateMagician() -> void:
	magicianType = types.values().pick_random()
	match magicianType:
		types.bokor:
			$Option1.pressed.connect(BaronSamedi)
			$Option2.pressed.connect(BravGede)
		types.shaman:
			$Option3.pressed.connect(Ukko)
			$Option4.pressed.connect(Tapio)
			$Option5.pressed.connect(Ahti)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
