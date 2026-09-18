class_name CardGraphics extends TextureRect

var texts = {
	Enums.Rank.ZERO : "0",
	Enums.Rank.ONE : "1",
	Enums.Rank.TWO : "2",
	Enums.Rank.THREE : "3",
	Enums.Rank.FOUR : "4",
	Enums.Rank.FIVE : "5",
	Enums.Rank.SIX : "6",
	Enums.Rank.SEVEN : "7",
	Enums.Rank.EIGHT : "8",
	Enums.Rank.NINE : "9",
	Enums.Rank.TEN : "10",
	Enums.Rank.ELEVEN : "11",
	Enums.Rank.TWELVE : "12",
	Enums.Rank.THIRTEEN : "13",
	Enums.Rank.JACK : "J",
	Enums.Rank.QUEEN : "Q",
	Enums.Rank.KING : "K",
	Enums.Rank.ACE : "A",
	Enums.Rank.PIE : "π",
	Enums.Rank.E : "E"
}

@export var heartSymbol: Texture2D
@export var diamondSymbol: Texture2D
@export var clubSymbol: Texture2D
@export var spadeSymbol: Texture2D
@export var starSymbol: Texture2D
@export var everythingSymbol: Texture2D
@export var nothingSymbol: Texture2D
var cardReference: card

func _updateSymbols(rank: Enums.Rank, suit: Enums.Suit) -> void:
	var c1 = ""
	if suit == Enums.Suit.HEARTS or suit == Enums.Suit.DIAMONDS:
		c1 = "[color=red]"
	elif suit == Enums.Suit.CLUBS or suit == Enums.Suit.SPADES:
		c1 = "[color=black]"
	elif suit == Enums.Suit.STARS:
		c1 = "[color=yellow]"
	else:
		c1 = "[color=green]"
	var text = c1 +  texts[rank] + "[/color]"
	$RankTextUp.text = text
	$RankTextDown.text = text
	var symbol : Texture2D
	match suit:
		Enums.Suit.HEARTS:
			symbol = heartSymbol
		Enums.Suit.DIAMONDS:
			symbol = diamondSymbol
		Enums.Suit.CLUBS:
			symbol = clubSymbol
		Enums.Suit.SPADES:
			symbol = spadeSymbol
		Enums.Suit.STARS:
			symbol = starSymbol
		Enums.Suit.ALL:
			symbol = everythingSymbol
		Enums.Suit.NONE:
			symbol = nothingSymbol
	$SuitIconDown.texture = symbol
	$SuitIconUp.texture = symbol
	
