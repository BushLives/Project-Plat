extends Node2D

onready var GUI = $Course/GUI
onready var HGUI = $Course/GUI/Health
onready var CGUI = $Course/GUI/Label
onready var Player = $Course/Warrior
func _ready():
	HGUI.Health.value = Player.health
	CGUI.text= (" X" + str(Player.coin)) 
	
