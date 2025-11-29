extends Node2D

var souls = 100
var playerDeck
var opponentDeck

var DeckStrings : Dictionary = {
	"normalDeck" : "noha.noh2.noh3.noha.nod10.noc7.noda.noha.noha.nosa.nohj",
	"opposingDeck" : "noha.noh2.noh3.noh4.noh5.noh6.noh7.noh8.noh9.noh10.nohj.nohq.nohk"
}

func _determineDeck(GivenDeck) -> String:
	if GivenDeck == $Deck:
		return DeckStrings["normalDeck"]
	if GivenDeck == $OpponentsDeck:
		return DeckStrings["opposingDeck"]
	return ""

func _drawcard() -> void:
	playerDeck._drawCard()
	$CardValueTotal.text = str(playerDeck._cardValuesSum())

func _playHand() -> void:
	$hitButton.visible = false
	$standButton.visible = false
	var playerScore
	if playerDeck._hasHand("BlackJack"):
		print("BlackJack!")
		playerScore = Global.bet+21*1.5
	elif playerDeck._hasHand("pair"):
		print("Pair!")
		playerScore = Global.bet+playerDeck.cardsInHand[0]._maxValue()*4
	elif playerDeck._hasHand("normal"):
		playerScore = Global.bet+playerDeck._cardValuesSum()
	else:
		print("Bust!")
		playerScore = 0
	print(str("total score = ", playerScore))
	while opponentDeck._cardValuesSum() < 17:
		await get_tree().create_timer(1.5).timeout
		opponentDeck._drawCard()
	print(str("opponent's hand: ", opponentDeck._cardValuesSum()))
	print(str("opponent's score: ", opponentDeck._cardValuesSum()*0.5))
	if(opponentDeck._cardValuesSum()*0.5 > playerScore):
		print("you lost!")
	else:
		print("you won!")

func _increase() -> void:
	if Global.bet < souls:
		Global.bet += 1

func _decrease() -> void:
	if Global.bet > Global.minii:
		Global.bet -=1


func _placeBet() -> void:
	var HitButton = Button.new()
	var StandButton = Button.new()
	HitButton.text = "hit"
	StandButton.text = "Stand"
	add_child(HitButton)
	add_child(StandButton)
	HitButton.position = Vector2(400,300)
	HitButton.pressed.connect(_drawcard)
	HitButton.name = "hitButton"
	StandButton.position = Vector2(450,300)
	StandButton.pressed.connect(_playHand)
	StandButton.name = "standButton"
	$increase.visible = false
	$decrease.visible = false
	$placebet.visible = false
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerDeck = $Deck
	opponentDeck = $OpponentsDeck
	var Increasebutton = Button.new()
	var Decreasebutton = Button.new()
	var PlaceBetButton = Button.new()
	Increasebutton.name = "increase"
	Decreasebutton.name = "decrease"
	PlaceBetButton.name = "placebet"
	Increasebutton.text = "increase"
	Decreasebutton.text = "decrease"
	PlaceBetButton.text = "place bet"
	Increasebutton.pressed.connect(_increase)
	Decreasebutton.pressed.connect(_decrease)
	PlaceBetButton.pressed.connect(_placeBet)
	add_child(Increasebutton)
	add_child(Decreasebutton)
	add_child(PlaceBetButton)
	Increasebutton.position = Vector2(200,200)
	Decreasebutton.position = Vector2(300,200)
	PlaceBetButton.position = Vector2(400,200)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
