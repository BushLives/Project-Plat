extends Node2D
onready var CoinGUI := $CanvasLayer/Label
onready var player := $Warrior
onready var healthbar := $CanvasLayer/Health

func _process(delta):
	CoinGUI.text =(" X" + str(player.coin))
	healthbar.value = player.health
