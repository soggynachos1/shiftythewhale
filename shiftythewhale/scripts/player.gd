extends CharacterBody2D 
class_name Player


var speed = 300.0

	
 
@onready var anim_sprite: AnimatedSprite2D = $orca


func _physics_process(delta: float):
	var direction = Input.get_vector("move_down","move_left","move_right","move_up")


	
	if Input.is_action_pressed("move_right"):
		anim_sprite.play("right")
		direction.x = 1
		direction.y = 0
		
	if Input.is_action_pressed("move_left"):
		anim_sprite.play("left")
		direction.x = -1	
		
	if Input.is_action_pressed("move_up"):
		
		direction.y = -1
		
	if Input.is_action_pressed("move_down"):
		direction.y = 1
		
	velocity = direction * speed
	direction.normalized()
	
	
	
	move_and_slide()
	
