extends Node2D

#This is where the collision signal is given a function . . .
func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body  is Player:
		print("Ouch! You've been got!")
		body.reset_player()
