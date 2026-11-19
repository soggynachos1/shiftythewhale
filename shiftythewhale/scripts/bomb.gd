extends Node2D

#This is where the collision signal is given a function . . .
func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body  is Player:
		print("Ouch-y! minus 1 health!!!")
		body.reset_player()
