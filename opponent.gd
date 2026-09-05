extends Node2D

var card1 : card
var card2 : card
var availableCards : Array[card]
var layer : int = 0
var roundsWon : int = 0
var roundN : int = 0

func _createBig(f : float) -> BigNumber:
	var b : BigNumber = BigNumber.new()
	b.exponent = floor(log(abs(f))/log(10))
	b.mantissa = f / pow(10.0,b.exponent)
	return b

var baseScores : Dictionary = {
	0 : 15.0,
	1 : 75.0,
	2 : 400.0,
	3 : 2000.0,
	4 : 10000.0,
	5 : 50000.0,
	6 : 250000.0,
	7 : 1250000.0
}

var roundMults : Dictionary = {
	0 : 1,
	1 : 1.25,
	2 : 1.5,
	3 : 2.0,
	4 : 3,
	5 : 4.5,
	6 : 6,
	7 : 8,
	8 : 11,
	9 : 15,
	10 : 25
}

func _ready() -> void:
	EventBus.roundWon.connect(_IncreaseRoundsWon)
	EventBus.LayerChanged.connect(_changeLayer)
	EventBus.betPlaced.connect(_calculateScore)
	
func _changeLayer(l : int) -> void:
	layer = l
	
func _IncreaseRoundsWon(_n) -> void:
	roundsWon+=1

func _calculateScore() -> void:
	var baseS : float = baseScores[layer]
	if roundN > 10:
		baseS*=100.0
	else:
		baseS*=roundMults[roundN]
	baseS = baseS * (1 + 0.1*roundsWon)
	baseS*=1.0
	var b = _createBig(baseS)	
	EventBus.opponentScoreCalculated.emit(b)
