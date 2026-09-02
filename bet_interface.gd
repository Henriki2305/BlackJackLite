extends Control

var bet = 0

func _ready() -> void:
	EventBus.betButtonsHidden.connect(hide)
	EventBus.betButtonsRevealed.connect(show)

func _increaseBet() -> void:
	bet +=1
	
	EventBus.betIncreased.emit()
	$BetAmount.text = str(bet)
	
func _decreaseBet() -> void:
	bet = max(1,bet-1)
	EventBus.betDecreased.emit()
	$BetAmount.text = str(bet)


func _playBet() -> void:
	hide()
	EventBus.betPlaced.emit()
