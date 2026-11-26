extends Node2D

@onready var parent = get_parent() as PathFollow2D
@onready var enemy_sprite: AnimatedSprite2D = $Area2D/meg




func _ready():
	parent.progress_ratio = 0

func _on_area_2d_body_entered(body: Node2D):
	if body  is Player:
		body.take_damage()
		body.update_heart_display()
	
	
	
	
func _physics_process(delta: float):
	if parent is PathFollow2D:
		parent.set_progress(parent.get_progress() + 500 * delta)
		if parent.progress_ratio > 0.0602 and parent.progress_ratio < 0.2925:
			enemy_sprite.play("meg_left")	
		if parent.progress_ratio > 0.2925 and parent.progress_ratio < 0.5635:
			enemy_sprite.play("meg_right")	
		if parent.progress_ratio > 0.5635 and parent.progress_ratio < 0.6505:
			enemy_sprite.play("meg_left")	
		if parent.progress_ratio > 0.6505 and parent.progress_ratio < 0.6831:
			enemy_sprite.play("meg_right")	
		if parent.progress_ratio > 0.6831 and parent.progress_ratio < 0.83:
			enemy_sprite.play("meg_left")	
		if parent.progress_ratio > 0.83 and parent.progress_ratio < 0.8843:
			enemy_sprite.play("meg_right")	
		if parent.progress_ratio > 0.8843 and parent.progress_ratio < 1:
			enemy_sprite.play("meg_left")	
	

		
		

	
		
	



	

		
