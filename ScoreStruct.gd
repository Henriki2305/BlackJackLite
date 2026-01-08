class_name Scoring extends Resource

var Vals : Array = []

func _updateValue() -> void:
	var n : int = len(str(Vals[0]).split(".")[0])
	if n > 10:
		var x = n - 1
		Vals[0] = Vals[0] / pow(10,x)
		Vals[1] += x
	elif n > 1 && Vals[1] > 1:
		Vals[0] = Vals[0] / pow(10,n-1)
		Vals[1] += (n-1)

func _resVal(n : int = 0.0) -> void:
	Vals[0] = n
	Vals[1] = 0

func _setVal(n) -> void:
	Vals[0] = n
	_updateValue()

func _AddNum(n) -> void:
	Vals[0] = Vals[0] + ( n / pow(10,Vals[1]))
	_updateValue()

func _MultiplyByNum(n) -> void:
	Vals[0] = Vals[0] * n
	_updateValue()

func _MultipliedByNum(n) -> Scoring:
	var s = Scoring.new()
	s.Vals = [Vals[0]*n,Vals[1]]
	s._updateValue()
	return s

func _GreaterThan(s : Scoring) -> bool:
	if Vals[1] > s.Vals[1]:
		return true
	else:
		return Vals[1] == s.Vals[1] && Vals[0] > s.Vals[0]

func _ValMult(s1 : Array, s2 : Array) -> Array:
	var A : Array
	var a1: float = s1[0]
	var b1: float = s2[0]
	var a2: int = s1[1]
	var b2: int = s2[1]
	var c1: float = a1*b1
	var c2: int = a2+b2
	A = [c1,c2]
	return A

func _IntoText() -> String:
	if Vals[1] == 0:
		return str(int(Vals[0]))
	return str( "%.4f" % Vals[0],"E",Vals[1])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
