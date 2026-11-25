extends CharacterBody2D


var speed = 50

 
@onready var enemy: AnimatedSprite2D = $meg


func _physics_process(_delta: float):
	var direction: Vector2 = Vector2.RIGHT 
	if direction.x < 0:
		enemy.play("meg_left")
	elif direction.x > 0:
		enemy.play("meg_right")
	

func respawn():
	pass
	#global_position = spawn_position # set to a random position later
	
   	

# func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body  is Player:
		#print("Ouch-y! minus 1 health!!!")
		#body.reset_player()
