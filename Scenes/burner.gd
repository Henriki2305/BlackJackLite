class_name burner extends Node2D

var g: Game
var sk : bool = false

func _button(i) -> void:
	g._getPlayerDeck()._burnCards(i)
	if sk:
		g._advance()
		queue_free()
	else:
		sk = true
	_showPrimary()
	
func _showPrimary() -> void:
	$BurnRankRange.show()
	$BurnSuit.show()
	$SkipBurning.show()
	$BurnDiamonds.hide()
	$BurnHearts.hide()
	$BurnClubs.hide()
	$BurnSpades.hide()
	$BurnStars.hide()
	$BurnFaces.hide()
	$BurnBig.hide()
	$BurnSmall.hide()
	
func _showSecondary() -> void:
	$BurnRankRange.hide()
	$BurnSuit.hide()
	$SkipBurning.hide()
	$BurnDiamonds.show()
	$BurnHearts.show()
	$BurnClubs.show()
	$BurnSpades.show()
	$BurnStars.show()
	$BurnFaces.show()
	$BurnBig.show()
	$BurnSmall.show()
	
	
func _showSuits() -> void:
	_showSecondary()
	
func _showRanks() -> void:
	_showSecondary()
	
func _skip() -> void:
	if sk:
		g._addToSouls(5)
	else:
		g._addToSouls(15)
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BurnRankRange.pressed.connect(_showRanks)
	$BurnSuit.pressed.connect(_showSuits)
	$SkipBurning.pressed.connect(_skip)
	$BurnDiamonds.pressed.connect(_button.bind("diamonds"))
	$BurnHearts.pressed.connect(_button.bind("hearts"))
	$BurnClubs.pressed.connect(_button.bind("clubs"))
	$BurnSpades.pressed.connect(_button.bind("spades"))
	$BurnStars.pressed.connect(_button.bind("stars"))
	$BurnFaces.pressed.connect(_button.bind("faces"))
	$BurnBig.pressed.connect(_button.bind("big"))
	$BurnSmall.pressed.connect(_button.bind("small"))
	g = get_parent()
	_showPrimary()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
