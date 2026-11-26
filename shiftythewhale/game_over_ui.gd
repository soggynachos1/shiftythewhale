extends Control


@onready var coin_label: Label = $coinLabel

var coins = 0

func _ready():
	pass
	

func _on_coins_collected(value):
	coins += value
	coin_label.text = str(coins) + " Coins collected"

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
