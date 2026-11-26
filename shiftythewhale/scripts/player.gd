extends CharacterBody2D 
class_name Player

@onready var anim_sprite: AnimatedSprite2D = $orca

var speed = 500.0
var hearts_lists: Array[TextureRect]
var health = 3
var coin_counter = 0

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
	
	if health <= 0:
		game_over()
		
func game_over():
	var scene = load("res://scenes/game_over_ui.tscn") as PackedScene
	get_tree().change_scene_to_packed.call_deferred(scene)
	
func set_coin(new_coin_count: int) -> void:
	coin_counter = new_coin_count
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		set_coin(coin_counter + 1)
	
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


	
	
	
	
