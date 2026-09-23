extends Control

func _ready() -> void:
	EventBus.betButtonsHidden.connect(hide)
	EventBus.betButtonsRevealed.connect(show)
	EventBus.advanceRound.connect(show)
	EventBus.endRound.connect(_resetBet)

func _resetBet() -> void:
	Global.bet = 0
	$BetAmount.text = str(Global.bet)
	
func _increaseBet() -> void:
	Global.bet +=1
	Global.bet = min(Global.bet, Global.soulShardsAmount)
	EventBus.betIncreased.emit()
	$BetAmount.text = str(Global.bet)
	
func _decreaseBet() -> void:
	Global.bet = max(1,Global.bet-1)
	EventBus.betDecreased.emit()
	$BetAmount.text = str(Global.bet)


func _playBet() -> void:
	hide()
	EventBus.betPlaced.emit()
