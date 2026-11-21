extends CharacterBody2D 
class_name Player


var speed = 300.0

	
 
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float):
	var direction = Input.get_vector("move_down","move_left","move_right","move_up")
	
	
	if Input.is_action_pressed("move_right"):
		
		direction.x = 1
		
		
	if Input.is_action_pressed("move_left"):
		
		direction.x = -1
	
		
		
			
			
		
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	if Input.is_action_pressed("move_down"):
		direction.y = 1
	velocity = direction * speed
	
	
	
	
	move_and_slide()
	
