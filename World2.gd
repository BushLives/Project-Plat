extends Node2D
onready var CoinGUI := $CanvasLayer/Label
onready var player := $Warrior

func _physics_process(delta):
	CoinGUI.text =(" X" + str(player.coin))
