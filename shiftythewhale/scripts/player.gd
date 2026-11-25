extends CharacterBody2D 
class_name Player

@onready var anim_sprite: AnimatedSprite2D = $orca

var speed = 500.0
var hearts_lists: Array[TextureRect]
var health = 3

func _ready() -> void:
	var hearts_parent = $CanvasLayer/HBoxContainer
	for child in hearts_parent.get_children():
		hearts_lists.append(child)
		print(hearts_lists)
		
func take_damage():
	if health > 0:
		health -= 1
		update_heart_display()
		
func update_heart_display():
	for i in range(hearts_lists.size()):
		hearts_lists[i].visible = i < health
	

	
	
		
		



#physics this is where all movement goes
func _physics_process(_delta: float):
	var direction = Input.get_vector("move_down","move_left","move_right","move_up")

	if Input.is_action_pressed("move_right"):
		anim_sprite.play("right")
		direction.x = 1
		direction.y = 0
		
	if Input.is_action_pressed("move_left"):
		anim_sprite.play("left")
		direction.x = -1	
		direction.y = 0
		
	if Input.is_action_pressed("move_up"):
		direction.x = 0
		direction.y = -1
		
	if Input.is_action_pressed("move_down"):
		direction.x = 0
		direction.y = 1
		
	velocity = direction * speed
	direction.normalized()
	
	move_and_slide()
	
	
	
	
	
