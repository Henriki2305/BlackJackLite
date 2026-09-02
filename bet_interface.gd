extends Control

var bet = 0

func _ready() -> void:
	pass

func _increaseBet() -> void:
	bet +=1
	EventBus.betIncreased.emit()
	$BetAmount.text = str(bet)
	
func _decreaseBet() -> void:
	bet -=1
	EventBus.betDecreased.emit()
	$BetAmount.text = str(bet)


func _playBet() -> void:
	pass
